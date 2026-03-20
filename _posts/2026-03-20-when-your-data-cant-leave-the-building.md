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

A small language model (SLM) is typically 1-4 billion parameters, compared to 70-400 billion for the cloud models. At first glance, that's a massive capability gap. And for general-purpose tasks — writing essays, coding, broad-knowledge Q&A — it is.

But enterprise problems aren't general-purpose. The recruiter doesn't need a model that can write poetry and debug Rust. They need one that can read a job description and output a structured skills assessment against a specific framework. The vocabulary is bounded. The output format is defined. The success criteria are measurable.

This is where fine-tuning changes the equation. You take a capable-but-generic base model and train it on your domain until it becomes a specialist. The model doesn't need to know everything — it needs to know *your* things very well.

The result: a 1.6GB file that runs on a laptop, responds in milliseconds, costs nothing per inference, and never sends a byte of data to anyone.

## Building the Model Factory

We're not building one model. We're building a **pipeline** — a reusable model factory that can produce domain-specific SLMs for different applications from the same codebase. Recruitment is one domain. There are others.

The factory works in stages, and each stage exists for a reason rooted in the business problem, not just the technology.

### Stage 1: The Teacher Creates the Curriculum

The base model (a 3-billion-parameter open-source model) knows language but not our domain. We need training examples.

Rather than manually writing thousands of examples — which would be slow, expensive, and inconsistent — we use a large cloud model as a "teacher." Claude generates high-quality training data: question/answer pairs, structured assessments, edge cases. The teacher sees our framework definitions and produces examples that follow the patterns we need.

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

We fine-tune the base model using LoRA — Low-Rank Adaptation. This is a technique that freezes most of the model's weights and trains a small adapter (~50MB) that modifies the model's behaviour. It's fast, memory-efficient, and can run on a single Apple Silicon Mac.

The business reason LoRA matters: it means the training infrastructure is a laptop, not a data centre. The team that maintains the model can retrain it when the framework updates, without submitting a GPU requisition.

We target both the attention layers (how the model relates words to each other) and the feed-forward layers (how it processes information). Including the feed-forward layers — a detail we learned the hard way — dramatically improves the model's ability to produce valid structured output. When your application expects JSON, "almost valid JSON" is the same as broken.

### Stage 3: The Student Gets Tested (RLVR)

After fine-tuning, the model can mimic the teacher's format. But mimicry isn't understanding. If the teacher said a particular skill was level 5, the student will say level 5 for *that* example. What about a job description it's never seen?

Reinforcement Learning from Verifiable Rewards (RLVR) addresses this. Instead of learning from human preferences (which are subjective and expensive to collect), the model learns from signals we can check programmatically:

- **Is the JSON valid?** (Parser says yes or no — no ambiguity)
- **Are the referenced skills real?** (Lookup against the framework — they exist or they don't)
- **Is the assigned level reasonable?** (Within ±1 of expert consensus)
- **Did the model hallucinate a skill that isn't in the framework?** (Verifiable)

We combine these into a single score:

```python
forge_score = (
    0.30 * json_validity      +
    0.25 * skill_f1            +
    0.25 * level_within_1      +
    0.15 * (1 - hallucination) +
    0.05 * evidence_grounding
)
```

The model generates outputs, gets scored, and adjusts. The technique we use — GRPO (Group Relative Policy Optimization) — is elegant because it doesn't need a separate "critic" model. It generates a batch of outputs, scores them all, and learns from the relative differences. The best outputs in the batch become the training signal.

This is the stage where the model goes from "can produce the right format" to "actually understands the domain."

### Stage 4: The Model Ships as a File

The LoRA adapter gets fused into the base model's weights. The combined model gets quantised to 4-bit using AWQ (Activation-aware Weight Quantization), which protects the most important weights from precision loss. The result is a standalone ~1.6GB file.

The consumer application loads this file at startup, the same way it would load a database or a config file. It calls the model through a simple protocol — send text in, get structured output back. If the model improves, you ship a new file. The application code doesn't change.

```
Model Factory (training) → model.mlx (1.6GB file) → Consumer App (inference)
```

The factory never touches production. The consumer never touches training. The data never leaves the device. These boundaries are the entire point.

## What the Numbers Look Like

From our [benchmarking work](/2026/03/18/running-llms-on-apple-silicon-mlx-lm-benchmarks/) with base models on Apple Silicon:

| Metric | What It Means |
|---|---|
| **96-196 tokens/sec** | Faster than you can read the response |
| **1-3 GB memory** | Fits alongside the application, browser, and OS |
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

**Apple Silicon is a real training platform** at the 3-4B parameter scale. An M-series Mac with 36GB of unified memory handles LoRA fine-tuning comfortably. You don't need a cloud GPU for models this size.

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
