---
layout: post
title: "Silent Is Not Stuck: What Two Hangs Taught Me About Observable Pipelines"
date: 2026-04-11
categories: [Engineering, Operations]
tags: [observability, pipelines, llm-tools, kuzuctl, ollama, debugging]
excerpt: "A six-hour hang and a fake embed bug, both caused by the same thing: a loop that had no way to prove it was still working. Two fixes, one rule."
author: Sailesh Panchal
---

Two days ago, my nightly knowledge pipeline hung silently for six and a half hours on a single [[M4 Pro MacBook Pro|Ollama]] call. Yesterday, I thought I'd found a silent logic bug in the same pipeline's refine step — all 754 insights had zero embeddings and the manifest was all zeros. I spent an hour instrumenting and diagnosing before I realised the "bug" was the same class of problem as the hang, one layer down.

Both of them came from the same missing thing: **a loop that had no way to prove it was still working.**

## The First Incident: The 6.5-Hour Populate Hang

The pipeline runs at 02:00 every night via launchd. `populate` is the step where a local LLM reads each new source file and extracts structured insights. It hits Ollama over HTTP, one source at a time, and writes the results to SQLite.

On the night of April 10th, populate started at 02:00 and was still running at 08:30. No output. No errors. No progress. Just a process sitting at 0% CPU, waiting on a socket.

When I finally killed it and looked at `ps` + `lsof`, the process was stuck mid-HTTP-call to Ollama, which had apparently died or stalled but not closed the connection. `URLSession` had no resource timeout set, so the call would wait forever. Six and a half hours of night-cron time, burned on nothing.

The fix was three lines of code plus a structural habit:

1. **Hard wall-clock timeout on every external call.** A dedicated `URLSession` with `timeoutIntervalForResource = 300s`. Bound the worst case.
2. **One retry on transient failures.** The second attempt often succeeds because the upstream has recovered.
3. **Per-item heartbeat to stderr.** `[populate] 47/162 source-name.md` every single iteration. Now if the pipeline is stuck, I can tell in two seconds.

That became Milestone A.5 — "[[Cloud-native architecture|observability]] and resume, before anything new ships." I sat on building any new pipeline features until the pipeline itself could tell me what it was doing.

## The Second Incident: The Fake Embed Bug

Yesterday I ran the pipeline again, this time with decision-capture features layered on top. Refine completed. I checked the manifest: zero embeddings, zero enrichments, zero tensions detected. I queried the live database directly — 754 insights, every single one with `NULL` embeddings.

My first reading: refine has a logic bug. It's silently no-oping on the embed pass. Maybe `supportsEmbedding` is returning false. Maybe the batch loop is skipping rows. Maybe the Ollama embed endpoint is broken.

I started instrumenting. I added stderr logging around the embed pass. I checked that `nomic-embed-text` was loaded in Ollama. I ran a manual `curl` against `/api/embed`. Everything worked. The model was there. The endpoint responded. So why was refine producing nothing?

The answer, once I stopped staring at embed and actually read the refine flow end-to-end: **refine wasn't broken. It had never finished.** The enrich pass runs before embed, processes each sparse insight sequentially, and takes about four seconds per call against gemma4. With 754 sparse insights, that's about fifty minutes of work before embed even starts. Fifty minutes during which refine produces exactly zero bytes of output. Indistinguishable from a hang. On the previous night's run, the populate hang had blocked refine from ever starting on the current dataset. On tonight's, the enrich pass had been honestly chewing through the work and I'd killed it before it got to embed.

## The Same Root Cause, Two Layers Apart

This is where I realised the two incidents were actually the same incident. A.5 made the *pipeline* observable — you can see which phase is running, how far it's got, whether the lockfile is held, when the last heartbeat fired. But the individual *passes inside refine* were still blind boxes. Each pass logged "starting" and then went quiet for anywhere from 30 seconds to an hour. If any one of them got slow, or stuck, or hit one bad row, you couldn't tell which without killing the process and looking at the database state after the fact.

So the fix mirrored A.5, one layer down:

1. **Start and end markers on every refine pass.** `[refine:enrich] start — 754 sparse insights` at entry, `[refine:enrich] done (0 failed)` at exit. No ambiguity about which pass is running.
2. **Per-item progress every 5 items.** Slow enough to not drown the log, [[Agile methodology|fast]] enough that you can watch progress in real time and calculate ETA.
3. **Try/catch around every external call, per row.** If one insight's LLM call fails, log it, increment a counter, continue. One bad row can never kill the whole pass again.

The last point turned out to matter more than the logging. Before the fix, enrich was already ~fifty minutes of sequential external work. If any one of those 754 calls had thrown (Ollama indigestion, a badly-formed title, a transient network blip), the entire pass would have died and we'd have wasted the preceding work. With per-row tolerance, one flaky response just bumps a skip counter and the other 753 calls complete.

## The Rule I Wrote Down

After the second fix, I wrote a new line in my permanent project [[LLM-based agents|memory]]:

> **External calls in long-running passes need a stderr heartbeat every N items and a try/catch around every single call. Silent "stuck" is almost never actually stuck. It's missing instrumentation.**

That's the entire rule. It sounds obvious written down. It wasn't obvious while I was staring at a query that returned zero embeddings, convinced there was a logic bug.

There are two reasons engineers skip this, and I skipped it for both:

- **You write the code while the dataset is small.** My unit tests had 3 insights, not 754. At 3 insights, enrich finishes in 12 seconds, so "silence for a minute" never happens. The pathology doesn't show up until production load.
- **You think logging is a polish task.** Heartbeat lines look like chrome you can add later. They're not. They are the only way a human can tell a working loop from a dead one, and if you don't have them, every unexpected behaviour looks like a bug.

## What I'd Tell Someone Building A Similar System

If you're building a pipeline that calls external services in a loop — an LLM, an HTTP API, a database-on-another-box, anything where latency is not under your control — build the observability *first*. Not first in priority, first in literal code-writing order. Before the happy path works, make sure the unhappy path is legible:

- Heartbeat every N items, where N is small enough that a human watching the log can see it move
- Hard wall-clock timeout on every external call, not just the session default
- Per-item try/catch so one bad row can never kill a long-running batch
- A progress sidecar written to disk so a killed process leaves behind evidence of how far it got
- Postmortem dump on SIGTERM so the nightly cron's failures are diagnosable in the morning

None of these are hard to build. All of them are hard to *remember to build before you need them*. The rule I'm trying to hold myself to: any loop over external work gets instrumented the same day it's written. Not the day it breaks in production.

The knowledge pipeline is running as I write this. The enrich pass is at 405 of 754, ten minutes from embed, and I can see every step of it in my terminal. Which is the entire point.
