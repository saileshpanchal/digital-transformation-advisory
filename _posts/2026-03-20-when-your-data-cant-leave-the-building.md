---
title: "When Your Data Can't Leave the Building: Training Small Language Models for Enterprise"
date: 2026-03-20T10:00:00+00:00
categories: [AI, Engineering]
tags: [slm, fine-tuning, on-device-ai, privacy, enterprise-ai, mlx, apple-silicon, lora]
excerpt: "Cloud AI APIs are powerful, but some data can't leave the building. We're building a pipeline that trains small, domain-specific language models to run entirely on-device — no API calls, no data exfiltration, no per-token costs. Here's why, and how."
---

Picture this. You're a recruiter at a specialist firm. A hiring manager sends you a job description for a Lead Platform Engineer. You need to understand exactly what skills this role requires, map them to an industry framework, and match against your candidate database — ideally in the time it takes to read the email.

Now picture the data involved. CVs with home addresses, salary histories, and career trajectories. Skills assessments tied to named individuals. Internal compensation benchmarks. Disability and diversity information. Client organisation charts.

You call a cloud API — GPT-4, Claude, whatever's flavour of the month — and every piece of that data leaves your network, crosses the internet, and arrives at a third party's data centre. The API terms say they won't train on it. Your compliance officer says the risk assessment takes six weeks. Your client's contract says their data stays in the UK.

This isn't a hypothetical. It's the conversation we have with almost every enterprise client who wants to use AI on sensitive data. And the answer is usually the same: "We'd love to, but we can't."

## The Privacy Tax

The standard solution is to sanitise the data before sending it to a cloud API. Strip names, mask salaries, replace company names with placeholders. This works — for simple tasks. But language understanding is contextual. "10 years at a Big Four firm" carries different weight than "10 years in a startup." Sanitising the context destroys the signal.

The other solution is to run everything on-premises. Deploy a 70-billion-parameter model on your own GPUs. This works too — if you have a team of ML engineers, a rack of A100s, and a budget that doesn't need to survive a quarterly review.

What we actually need is a model small enough to run on the hardware people already have — a laptop, a phone, a Mac Mini in a server cupboard — that understands the specific domain well enough to be useful. Not a general-purpose genius. A specialist.

## Small Language Models: The Right Tool for Bounded Problems

A small language model (SLM) is typically 2-4 billion parameters, compared to 70-400 billion for the cloud models. At first glance, that's a massive capability gap. And for general-purpose tasks — writing essays, coding, broad-knowledge Q&A — it is.

But enterprise problems aren't general-purpose. The recruiter doesn't need a model that can write poetry and debug Rust. They need one that can read a job description and output a structured skills assessment against a specific framework. The vocabulary is bounded. The output format is defined. The success criteria are measurable.

This is where fine-tuning changes the equation. You take a capable-but-generic base model and train it on your domain until it becomes a specialist. The model doesn't need to know everything — it needs to know *your* things very well.

We train two tiers from the same pipeline and the same training data:

| Tier | Base Model | Target | Size at 4-bit |
|---|---|---|---|
| **iPhone** | Qwen 3.5 2B | iPhone 15 Pro+ (8GB RAM) | ~1.2GB |
| **Laptop** | Qwen 3.5 4B | Mac with 16GB+ RAM | ~2.5GB |

The laptop model scores higher — more parameters means more capacity for domain knowledge. But the iPhone model still passes minimum accuracy thresholds, and it runs on hardware that fits in a pocket. The consumer app selects the right tier at runtime based on what device it's on. Same protocol, same prompt, different model file.

## Building the Model Factory

We're not building one model. We're building a **pipeline** — a reusable model factory that can produce domain-specific SLMs for different applications from the same codebase. Recruitment is one domain. There are others.

The factory works in stages, and each stage exists for a reason rooted in the business problem, not just the technology.

### Stage 1: The Gold Set and the Teacher

Before any training happens, we build the exam paper: 200 expert-validated examples. Real job descriptions, real experience statements, each mapped to SFIA competencies by hand, reviewed by domain experts. These 200 examples are *never* used in training. They exist solely to measure whether the model is improving — the same 200-question test, administered at every checkpoint. If you train on the exam, the scores are meaningless.

With the exam built, we need the curriculum. The base model (an open-source model (2 billion parameters for phones, 4 billion for laptops)) knows language but not our domain. Rather than manually writing 1,800 more examples — which would be slow, expensive, and inconsistent — we use a large cloud model as a "teacher." Claude generates high-quality training data: question/answer pairs, structured assessments, edge cases. The teacher sees our framework definitions and produces examples that follow the patterns we need.

```
Input:  "Senior Infrastructure Engineer — responsible for cloud
         platform strategy, team leadership, vendor management"

Output: {
  "skills": [
    {"name": "infrastructure design", "level": 5},
    {"name": "cloud services management", "level": 5},
    {"name": "technology leadership", "level": 4}
  ],
  "rationale": "Cloud platform strategy ownership with team and
                vendor management indicates senior autonomous
                practitioner level..."
}
```

The irony isn't lost on us: we send framework definitions (public information) to a cloud API to generate training data, specifically so that production data (private information) never has to make the same trip. The teacher trains the student. Then the student works alone.

### Stage 2: The Student Learns (LoRA Fine-Tuning)

A common assumption: you fine-tune a large model and then shrink it down to fit on a device. That's not what we do. **The training happens directly on the small models — 2B for iPhone, 4B for laptop.** The large model's job ended in Stage 1 — it created the curriculum. Now the students sit the exam alone.

We fine-tune each tier using LoRA — Low-Rank Adaptation. This freezes most of the model's weights and trains a small adapter (~50MB) that modifies the model's behaviour. Same training data, same technique, separate adapters for each model size. It's fast, memory-efficient, and can run on a single Apple Silicon Mac.

The business reason this matters: the training infrastructure is a laptop, not a data centre. The team that maintains the model can retrain it when the framework updates, without submitting a GPU requisition. You're not renting A100s to train a 70B model and then spending another day compressing it — you're training the exact model that will ship, on the hardware it will run on.

We target both the attention layers (how the model relates words to each other) and the feed-forward layers (how it processes information). Including the feed-forward layers — a detail we learned the hard way — dramatically improves the model's ability to produce valid structured output. When your application expects JSON, "almost valid JSON" is the same as broken.

### Stage 3: The Student Gets Tested (RLVR)

After fine-tuning, the model can mimic the teacher's format. But mimicry isn't understanding. If the teacher said a particular skill was level 5, the student will say level 5 for *that* example. What about a job description it's never seen?

This is where Reinforcement Learning from Verifiable Rewards (RLVR) takes over — and it's the stage that runs overnight with a measurable improvement cycle.

#### The 5-Minute Checkpoint Cycle

Here's what actually happens on the machine, concretely:

1. **Generate** — The model receives a batch of prompts (real job descriptions it hasn't seen in training). For each prompt, it generates a group of 8 candidate outputs. That's 8 different attempts at the same skills assessment.

2. **Score** — Every output gets scored against verifiable criteria. Not opinions — facts:
   - **Is the JSON valid?** (Parser says yes or no — no ambiguity)
   - **Are the referenced skills real?** (Lookup against the framework — they exist or they don't)
   - **Is the assigned level reasonable?** (Within ±1 of expert consensus)
   - **Did the model hallucinate a skill that isn't in the framework?** (Verifiable)

3. **Learn** — The technique we use — GRPO (Group Relative Policy Optimization) — ranks the 8 outputs within the group. The best-scoring outputs become the positive training signal; the worst become the negative signal. The model's weights adjust toward producing more outputs like the good ones. No separate "critic" model needed — the group comparison *is* the critic.

4. **Checkpoint** — Every ~5 minutes (roughly 50-100 training steps on Apple Silicon), the pipeline saves a snapshot: the current model weights, the timestamp, and the forge_score evaluated against the held-out gold set — the same 200 expert-validated examples, every time.

5. **Repeat** — The cycle restarts with new prompts. If the score improved, training continues. If it degraded (which can happen — the model sometimes optimises for one metric at the expense of another), the pipeline can revert to the last good checkpoint and adjust.

We combine the criteria into a single composite score:

```python
forge_score = (
    0.30 * json_validity      +
    0.25 * skill_f1            +
    0.25 * level_within_1      +
    0.15 * (1 - hallucination) +
    0.05 * evidence_grounding
)
```

#### Evidencing the Improvement

This is the part that matters to a CTO or a compliance officer: **can you prove the model got better?**

Yes — because every 5-minute checkpoint produces a forge_score against the same gold set. Plot them and you get a training curve:

```
Checkpoint    Time        forge_score    json_valid   skill_f1   hallucination
─────────────────────────────────────────────────────────────────────────────
ckpt-000      18:00       0.41           0.72         0.38       0.22
ckpt-012      19:00       0.58           0.94         0.51       0.15
ckpt-024      20:00       0.69           0.98         0.62       0.09
ckpt-048      22:00       0.77           1.00         0.71       0.05
ckpt-072      00:00       0.82           1.00         0.78       0.03
ckpt-096      02:00       0.84           1.00         0.81       0.02
ckpt-108      04:00       0.85           1.00         0.82       0.02  ← plateau
```

The pattern is consistent: JSON validity converges first (the model learns the format within the first hour), skill identification improves steadily through the night, and hallucination rate drops as the model learns what's *not* in the framework. Eventually the score plateaus — the model has extracted all the signal available from the training data. That's your stopping point.

Each checkpoint is a complete, usable model. If the 2am checkpoint scores 0.82 and the 4am checkpoint scores 0.85 but introduces a regression on one metric, you can ship the 2am version. The decision is auditable: here's the score at each point, here's what we chose, here's why.

This is fundamentally different from training a model and hoping it works. Every 5 minutes, you have evidence.

### Stage 4: The Model Ships as a File

Here's where the "train the small model directly" approach pays off. Each LoRA adapter — all those improvements from SFT, RLVR, and DPO — gets fused back into its base model's weights. No distillation step, no compression from a larger model. The adapter was always attached to the target-size model, so fusing is a simple matrix addition.

The combined models get quantised to 4-bit using AWQ (Activation-aware Weight Quantization), which protects the most important weights from precision loss. The result: two standalone files — 1.2GB for iPhone, 2.5GB for laptop.

The alternative approach — fine-tuning a 14B or 70B model first, then distilling down — would likely score higher on accuracy benchmarks. But it adds an entire extra stage (distillation), requires GPU servers for the larger model's training, and introduces a compression step where domain knowledge can be lost. By training each target-size model directly, every weight update is optimised for the model that will actually run in production.

The consumer application loads the appropriate file at startup based on device capability, the same way it would load a database or a config file. It calls the model through a simple protocol — send text in, get structured output back. If the model improves, you ship new files. The application code doesn't change.

```
Model Factory → sfia-mapper-iphone-4bit (1.2GB) → iPhone app (MLX.Swift)
(training)   → sfia-mapper-laptop-4bit  (2.5GB) → Mac app (MLX.Swift)
```

The factory never touches production. The consumer never touches training. The data never leaves the device. These boundaries are the entire point.

### A Note on the Teacher's Role During Training

In the stages above, the teacher (Claude) creates the data, then disappears. The student trains alone. But there's one technique in the pipeline — Generalized Knowledge Distillation (GKD) — where the teacher stays involved longer.

The problem it solves: during training, the student only sees the teacher's perfect outputs. But at inference time, the student works from its own imperfect outputs. This mismatch means the student can freeze when it encounters its own phrasing in production — like a student who studied from the textbook answer key and panics when the exam question is worded differently.

GKD mixes teacher corrections into the student's own outputs during training. The student generates a response, the teacher evaluates it, and the student learns from the gap. This closes the distribution mismatch and produces a more robust model — still 2-4 billion parameters, still running on the target device, but better at handling the messy inputs it will see in the real world.

## The Pattern Behind the Pattern

Here's something we didn't expect: the checkpoint-and-score loop from Stage 3 applies to problems that have nothing to do with model training.

The core structure is: **define a measurable outcome → build a fixed benchmark → iterate in short cycles → score against the benchmark → checkpoint on improvement → stop at plateau.** Andrej Karpathy designed this for training neural networks. But the requirements are simpler than they appear:

1. **Can you score the output without a human reviewing it?** (A parser, a lookup table, a test suite, a timer)
2. **Do you have a fixed benchmark you can commit to never contaminating?** (50-200 known-good examples)
3. **Can each iteration complete in under 5 minutes?** (Otherwise you get too few data points overnight)
4. **Can you save and restore state cleanly?** (Git commit, file copy, model checkpoint)

If all four are true, you can apply this pattern — whether you're training a model, optimising prompts, tuning API performance, or searching configurations.

**Prompt optimisation** is a particularly accessible example. You have a fixed prompt that works "okay." You have 200 gold examples with expected outputs. Each iteration: adjust the prompt wording, run it against all 200 examples via the API, score the outputs, keep the better prompt. No GPU required. Cost is API calls. Same evidence trail — a CSV showing prompt version, timestamp, composite score. Same audit story for a client.

**API performance tuning**: same loop. Fixed benchmark of representative API calls. Each iteration tries a different indexing strategy, query rewrite, or cache policy. Score = p95 latency × correctness. Checkpoint = the configuration that produced the best score.

The point isn't the technique — it's the evidence trail. In any of these applications, you end up with a CSV that shows measurable improvement over time. When someone asks "how do you know this is better?", you open the spreadsheet.

We've started treating the checkpoint above as a standard project evaluation: can we define a scoring function? Can we build a gold set? If yes, we apply the loop. If no, we don't pretend we can — we use human review, A/B testing, or structured evaluation instead. Knowing *when not to use it* is as important as having the tool.

## What the Numbers Look Like

From our [benchmarking work](/2026/03/18/running-llms-on-apple-silicon-mlx-lm-benchmarks/) with base models on Apple Silicon:

| Metric | What It Means |
|---|---|
| **96-196 tokens/sec** | Faster than you can read the response |
| **1.2-2.5 GB memory** | iPhone (1.2GB) or laptop (2.5GB) — fits alongside the app |
| **<100ms first token** | Feels instant in a user interface |
| **£0.00 per inference** | No API bill. No token counting. No cost anxiety |

These are base model numbers. A fine-tuned model will be slightly different, but in the same ballpark — the LoRA adapter adds knowledge, not computational overhead.

## The Business Case, Plainly

Cloud LLM APIs are extraordinary tools. We use them daily. But they create a dependency: on network availability, on third-party pricing, on data processing agreements, on compliance reviews that take longer than the project they're gate-keeping.

A fine-tuned SLM running on-device removes that dependency for the specific tasks it's trained for. It's not better than Claude at general reasoning. It's not trying to be. It's better at *one thing*, and it does that one thing locally, privately, and at zero marginal cost.

The model factory approach means we can produce these specialists for different domains without rebuilding the training infrastructure each time. A recruitment SLM. A compliance SLM. A customer service SLM. Same pipeline, different training data, different model files.

## What We've Learned So Far

We're still in the early stages of this build. Some things we've confirmed:

**Teacher quality beats teacher quantity.** 500 carefully crafted examples from Claude produce a better student than 5,000 low-effort ones. Garbage in, garbage out applies to synthetic data too.

**The output format is a training target, not a post-processing step.** If you need JSON, train the model to produce JSON. Don't train it to produce text and then try to parse the text into JSON. Including feed-forward layers in the LoRA target makes a measurable difference here.

**Apple Silicon is a real training platform** at the 2-4B parameter scale. An M-series Mac with 36GB of unified memory handles LoRA fine-tuning for both model tiers comfortably. You don't need a cloud GPU for models this size.

**The compliance conversation changes completely** when you can say "the data never leaves the device." Six-week risk assessments become same-week approvals. The model file ships like any other application asset — through your existing deployment pipeline, your existing change management, your existing security controls.

## When to Use Which

Not every problem needs an on-device model. Not every problem can be solved by a cloud API. Here's how we think about it:

| Your Situation | Recommendation |
|---|---|
| Data is public or low-sensitivity | Cloud API. Easier, more capable, maintained for you |
| Data is sensitive but tasks are varied | Cloud API with strong DPA, or anonymise first |
| Data is sensitive AND tasks are bounded | Fine-tuned SLM. This is the sweet spot |
| Tasks require broad world knowledge | Cloud API. SLMs don't know enough |
| You need zero-latency responses | On-device SLM. Nothing beats local inference |
| Budget scales with usage | SLM. Train once, infer forever |

The recruiter from the opening of this post? Sensitive data, bounded domain, defined output format, latency matters, privacy is non-negotiable. That's the sweet spot.

The model factory is how we get there.

---

*Sailesh Panchal is Director at Digital Transformation Advisory (DTA), specialising in technology strategy and AI-native architecture for enterprise clients.*
