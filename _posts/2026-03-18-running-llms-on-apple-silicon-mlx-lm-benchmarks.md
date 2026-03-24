---
title: "Running LLMs on Apple Silicon: MLX-LM Benchmarks for Qwen 3.5 and Llama 3.2"
date: 2026-03-18
categories: [AI, Apple]
tags: [mlx, apple-silicon, llm, qwen, llama, benchmarks, on-device-ai]
excerpt: "Hands-on benchmarks comparing Qwen3.5 2B, Qwen3.5 4B, and Llama 3.2 3B running locally on Apple Silicon via MLX-LM. Practical findings on speed, memory, output quality, and the sampling parameters that actually matter."
---

Apple Silicon changed the game for on-device machine learning. With unified memory and the Metal GPU sitting on the same die as the CPU, your MacBook can run billion-parameter language models without a discrete GPU. The missing piece was software. Apple's [MLX framework](https://github.com/ml-explore/mlx) and its companion library `mlx-lm` fill that gap.

This post documents a hands-on benchmarking session comparing three small language models locally on an Apple Silicon Mac, with real numbers, real output, and the pitfalls we hit along the way.

## The Setup

**Hardware:** Apple Silicon Mac (M-series, unified memory)

**Software stack:**
- Python 3.12 via [mise](https://mise.jdx.dev/)
- `mlx-lm` 0.31.1
- `mlx` 0.31.1 + `mlx-metal` 0.31.1

**Models tested:**
- `mlx-community/Qwen3.5-2B-4bit` (Alibaba, 2 billion parameters, 4-bit quantized)
- `mlx-community/Qwen3.5-4B-4bit` (Alibaba, 4 billion parameters, 4-bit quantized)
- `mlx-community/Llama-3.2-3B-Instruct-4bit` (Meta, 3 billion parameters, 4-bit quantized)

All models are pre-quantized MLX format from the `mlx-community` collection on Hugging Face. No conversion step needed.

**Installation** is one command:

```bash
pip install mlx-lm
```

If you use mise for version management:

```bash
mise install python@3.12
mise use --global python@3.12
pip install mlx-lm
```

## The Benchmark

We used a creative writing prompt to test both generation speed and output quality:

> Describe a medieval tavern at night. Include sensory details about the atmosphere, the patrons, and the food.

Each model was run with 256-300 max tokens. We tested twice: once with default sampling (greedy), and once with the official recommended sampling parameters.

### Raw Speed Numbers

All measurements taken on cached model runs (no download overhead):

| Metric | Qwen3.5-2B | Llama-3.2-3B | Qwen3.5-4B |
|---|---|---|---|
| **Prompt eval** | 705 tok/s | 920 tok/s | 390 tok/s |
| **Generation** | **196 tok/s** | 127 tok/s | 96 tok/s |
| **Peak memory** | **1.1 GB** | 2.0 GB | 2.5 GB |

The 2B model is roughly 2x faster than the 4B at generation, and uses less than half the memory. Llama 3.2 3B lands in the middle on both metrics.

For context, 96 tokens per second is still faster than you can read. All three models feel instant in interactive use.

## The Thinking Mode Trap

Here is where our initial benchmarks went wrong, and it contains an important lesson for anyone using Qwen3.5 models.

When we first ran the 4B model with a raw prompt via `mlx_lm.generate`, it produced this:

```
Here's a thinking process that leads to the description:
1. Analyze the Request:
   * Topic: A medieval tavern at night.
   * Key Elements: Sensory details...
2. Brainstorming & Imagery:
   * Setting: Stone walls, wooden beams...
```

Instead of writing prose, it dumped its internal reasoning chain. The 2B model, tested the same way, produced beautiful prose. Our initial conclusion was that the 2B was better. **That was wrong.**

### What happened

Qwen3.5 models have a **thinking mode** enabled by default. When thinking mode is active, the model emits a `<think>...</think>` block containing its reasoning before the actual response. The 4B model faithfully entered thinking mode. The 2B model happened not to, likely because the raw prompt format didn't trigger it as strongly.

The fix: use the tokenizer's chat template with thinking explicitly disabled.

```python
import mlx_lm
from mlx_lm.sample_utils import make_sampler

model, tokenizer = mlx_lm.load("mlx-community/Qwen3.5-4B-4bit")

messages = [{"role": "user", "content": "Your prompt here"}]
prompt = tokenizer.apply_chat_template(
    messages,
    add_generation_prompt=True,
    tokenize=False,
    enable_thinking=False  # This is the key parameter
)

sampler = make_sampler(temp=0.7, top_p=0.8, top_k=20, min_p=0.0)

response = mlx_lm.generate(
    model, tokenizer,
    prompt=prompt,
    max_tokens=300,
    sampler=sampler
)
```

**Lesson:** Always use `apply_chat_template()` with these models. Raw prompt strings bypass the model's expected input format and produce unpredictable behavior. This applies to all instruction-tuned models, not just Qwen.

### The Deeper Gotcha: Template Divergence Between Model Sizes

There's a subtler issue we discovered later while building [ForgeML](https://github.com/saileshpanchal/ForgeML) training pipelines. The Qwen3.5 2B and 4B variants ship with **different default chat templates** — and the difference is invisible during training.

- **Qwen3.5-2B** includes a pre-closed `<think></think>` block in its chat template. No reasoning by default.
- **Qwen3.5-4B** opens `<think>` and expects the model to fill it with reasoning content before responding.

During training, both templates produce the same format for complete conversations, so you won't notice anything. The divergence only appears at inference time when `add_generation_prompt=True` appends different suffixes depending on the model size. The 2B appends a clean assistant turn. The 4B appends an open thinking block that the model is expected to complete.

**This means the same inference code produces different behavior when you swap model sizes.** If you're deploying Qwen3.5 models for structured output (JSON, function calling, classification), you must explicitly set `enable_thinking=False` regardless of model size. This is not prominently documented in the model card.

```python
# Always be explicit about thinking mode — don't rely on defaults
prompt = tokenizer.apply_chat_template(
    messages,
    add_generation_prompt=True,
    tokenize=False,
    enable_thinking=False  # Required for consistent behavior across model sizes
)
```

If you're building a pipeline that supports multiple Qwen3.5 variants (for example, using the 2B for fast inference and the 4B for quality-critical tasks), test with both models at inference time. Training-time validation alone won't catch this.

<figure>
  <img src="{{ '/assets/diagrams/rendered/mlx-thinking-mode.svg' | relative_url }}" alt="Sequence diagram showing raw prompt vs chat template: raw prompt triggers thinking mode dump, chat template produces clean prose" style="width: 100%; max-width: 700px;">
  <figcaption>The difference between a raw prompt string and a properly formatted chat template. The tokenizer knows what the model expects. <em>Rendered with <a href="https://plantuml.com">PlantUML</a>.</em></figcaption>
</figure>

## Official Sampling Parameters

Qwen3.5 publishes recommended sampling parameters for different modes. For non-thinking (instruct) mode:

| Use Case | temp | top_p | top_k | min_p | presence_penalty |
|---|---|---|---|---|---|
| **General tasks** | 0.7 | 0.8 | 20 | 0.0 | 1.5 |
| **Reasoning tasks** | 1.0 | 0.95 | 20 | 0.0 | 1.5 |

For thinking mode (if you want the chain-of-thought reasoning):

| Use Case | temp | top_p | top_k | min_p | presence_penalty |
|---|---|---|---|---|---|
| **General tasks** | 1.0 | 0.95 | 20 | 0.0 | 1.5 |
| **Precise coding** | 0.6 | 0.95 | 20 | 0.0 | 0.0 |

In `mlx-lm` 0.31.1, you apply these through the `make_sampler` function:

```python
from mlx_lm.sample_utils import make_sampler

# Non-thinking, general tasks
sampler = make_sampler(temp=0.7, top_p=0.8, top_k=20, min_p=0.0)
```

Note: `mlx-lm`'s `make_sampler` does not expose `presence_penalty` directly as of v0.31.1. The `repetition_penalty` parameter in the generate function is the closest equivalent.

## Quality Comparison (Fair Test)

With thinking disabled and official sampling parameters applied to all models:

### Qwen3.5 4B

> The heavy oak doors of **The Gilded Tankard** groan open, admitting a rush of damp, starless night air that carries the scent of rain and wet cobblestones. Inside, the air is thick and warm, a palpable weight held back by the flickering glow of tallow candles... A floor-to-ceiling tapestry depicting knights in armor lines the far wall... In the corner, a lute player strums a mournful tune...

Structured, literary-quality prose. Named specific patron archetypes: a bearded merchant, roughnecks in leather, an elderly woman, a young scribe. Strong world-building details.

### Qwen3.5 2B

> The air inside **Blackwood's Oak** did not smell of wine or wood; it smelled of wet wool, damp stone, and the sharp, tangy scent of fresh rye bread... A low, rumbling murmur vibrates through the floorboards, not from the patrons, but from the wood itself...

Atmospheric and moody with a second-person perspective. Good sensory detail, though it occasionally repeats ideas and shifts tense.

### Llama 3.2 3B

> The medieval tavern was a warm and inviting haven, its wooden beams and stone walls glowing with a soft, golden light... At the bar, a jovial bartender polished a mug with a dirty rag...

Competent, readable prose. Safe and expected imagery. Gets the job done without surprises.

### Quality Verdict

| Dimension | 2B | Llama 3B | 4B |
|---|---|---|---|
| Prose coherence | Good | Good | Excellent |
| Character diversity | Adequate | Adequate | Rich |
| Sensory depth | Strong | Adequate | Richest |
| Consistency | Minor repeats | Solid | Excellent |

The 4B is clearly the better writer when properly configured. The 2B punches above its weight. Llama 3.2 3B is reliable but outclassed by both Qwen models in this creative task.

<figure>
  <img src="{{ '/assets/diagrams/rendered/mlx-model-selection.svg' | relative_url }}" alt="Model selection decision flow: speed picks Qwen 2B, quality picks Qwen 4B, ecosystem picks Llama 3.2 3B" style="width: 100%; max-width: 650px;">
  <figcaption>Choosing the right model depends on what matters most for your use case. <em>Rendered with <a href="https://d2lang.com">D2</a>.</em></figcaption>
</figure>

## Practical Recommendations

**Choose the 2B when:**
- You want the fastest possible generation (196 tok/s)
- Memory is constrained
- The task is straightforward: summaries, simple Q&A, boilerplate generation
- You're running a local API server and need throughput

**Choose the 4B when:**
- Output quality matters more than speed
- Multi-step reasoning, creative writing, or nuanced tasks
- You have 3+ GB of memory to spare (you do on any modern Mac)
- You're building something user-facing

**Choose Llama 3.2 3B when:**
- You need robust instruction-following without template fussing
- You want the largest community ecosystem and fine-tune availability
- The task is instruction-heavy rather than creative

## Running as a Local API Server

For development workflows, `mlx-lm` can serve an OpenAI-compatible API:

```bash
mlx_lm.server --model mlx-community/Qwen3.5-4B-4bit
```

This gives you a local endpoint at `http://localhost:8080` that accepts the same request format as the OpenAI API. You can point any OpenAI-compatible client at it for local inference.

## Key Takeaways

1. **Apple Silicon is a legitimate LLM inference platform.** Sub-100ms time-to-first-token and 96-196 tok/s generation with 1-3 GB of memory is practical for real applications.

2. **Model configuration matters more than model size.** A misconfigured 4B model produced worse output than a 2B model. The chat template, thinking mode flag, and sampling parameters are not optional details. Watch for template divergence between model sizes in the same family — Qwen3.5's 2B and 4B have different thinking-mode defaults that only surface at inference.

3. **The MLX ecosystem is production-ready.** Install with pip, download from Hugging Face, generate in three lines of Python. No CUDA, no Docker, no cloud API keys.

4. **Qwen3.5 is the new default for small local models.** Both the 2B and 4B outperform Llama 3.2 3B in quality at comparable or better speed. The only advantage Llama retains is its instruction-following robustness with raw prompts.
