---
title: "Building an Enterprise Security Chassis for Vapor: What Swift Was Missing"
date: 2026-03-23
categories: [Engineering, Security]
tags: [swift, vapor, server-side-swift, security, multi-tenant, oidc, authorization, open-source, apple-silicon, gstack, claude, perplexity]
excerpt: "Vapor is a capable web framework. But if you want enterprise-grade multi-tenant security — OIDC, RBAC, audit trails, tenant isolation — you're writing it from scratch. We built the chassis that closes those gaps, and the toolchain that made it possible."
---

Here's a test. Go to the Vapor ecosystem and find a reusable library that gives you multi-tenant authorization with deny-precedence policy composition, OIDC authentication with PKCE, tamper-evident audit logging, data classification enforcement, and tenant-scoped data access — all wired into a middleware pipeline that fails safe when you get the ordering wrong.

You won't find one. Not because Vapor is immature — it's a serious framework with a serious community. But the ecosystem has optimised for breadth (here's how to build a REST API, here's a CRUD template) rather than depth (here's how to build an application that a compliance officer would sign off on).

That's the gap we set out to close.

## The Gap, Specifically

We needed a server-side Swift web application for a recruitment platform. The data is sensitive — CVs, salary histories, skills assessments tied to named individuals. The platform is multi-tenant — different recruitment firms, different organisations, different data that must never leak across boundaries. We chose Vapor because we're an Apple-ecosystem shop and Swift 6's concurrency model is genuinely good for server work.

Then we started listing what we needed that didn't exist as a reusable package:

| Requirement | Vapor Ecosystem | What We Had to Build |
|---|---|---|
| OIDC authentication with PKCE | JWT verification exists; full OIDC flow doesn't | Complete OIDC controller with PKCE S256 |
| Multi-tenant authorization | Nothing reusable | 6-policy composite with deny precedence |
| Tenant-scoped data access | Nothing | Repository pattern enforcing isolation at query level |
| Data classification (sensitivity labels) | Nothing | Hard-gate policies for confidential/personal/privileged data |
| Tamper-evident audit logging | Nothing | Per-tenant SHA-256 hash chains |
| CSRF for Leaf + HTMX | Partial examples | Middleware with `req.csrfToken` for templates |
| Session management with key rotation | Nothing reusable | Dual-key HMAC-SHA256 with constant-time verification |
| Environment-driven auth modes | Nothing | Zero-code-change switching between disabled/optional/required |

Eight gaps. All of them are table stakes for enterprise software. None of them existed as drop-in packages.

## VaporSecurityKit: The Chassis

Rather than solving these problems inline — scattered across controllers, coupled to our application — we built a reusable library. Any Vapor application imports it via a `Package.swift` git URL and gets the full security chassis in one call:

```swift
try app.useSecurityKit(config: .fromEnvironment())
```

That single line wires up a six-stage middleware pipeline in the correct order, registers OIDC routes, and configures session management. The ordering matters — and that's exactly why it's encapsulated.

### The Middleware Pipeline (Order Is Security)

<figure>
  <img src="{{ '/assets/diagrams/rendered/middleware-pipeline.svg' | relative_url }}" alt="VaporSecurityKit middleware pipeline: RateLimit → CSRF → Audit → PrincipalResolution → TenantResolution → Authorization → Controller" style="width: 100%; max-width: 900px;">
  <figcaption>The six-stage middleware pipeline. Each stage reads values written by the previous stage — data flows left to right. <em>Rendered with <a href="https://d2lang.com">D2</a>.</em></figcaption>
</figure>

Each stage reads values written by the previous stage. PrincipalResolution can't run before the session middleware. TenantResolution needs the principal to cross-validate tenant claims. Authorization needs both. Getting this wrong doesn't throw a compiler error — it creates a security hole that passes all your tests.

By shipping the pipeline as a library with a fixed ordering, consuming applications can't accidentally reorder it. The security decision is made once, in the library, not re-made in every project.

### Deny-Precedence Policy Composition

Most authorization systems we've seen in web frameworks use a simple role check: does the user have the `admin` role? Yes or no. That works for toy applications. It falls apart when you need to combine multiple concerns — role, ownership, data sensitivity, sharing scope, workspace membership — into a single access decision.

Our `CompositePolicy` evaluates all applicable policies and applies a strict precedence:

1. Any policy returns `.deny` → access denied (deny is final, regardless of order)
2. Any returns `.elevationRequired` → privilege elevation required
3. At least one returns `.allow` → access granted
4. Everything abstains → denied by default

The critical property: **order doesn't affect the security decision.** You can add policies, remove policies, reorder policies — the deny-precedence semantics are invariant. This is harder to get wrong than a chain of `if` statements.

<figure>
  <img src="{{ '/assets/diagrams/rendered/policy-evaluation.svg' | relative_url }}" alt="CompositePolicy deny-precedence evaluation: all policies evaluated in parallel, any deny is final, then elevation check, then allow check, deny by default" style="width: 100%; max-width: 600px;">
  <figcaption>Deny-precedence evaluation. All six policies run in parallel — a single deny overrides any number of allows. <em>Rendered with <a href="https://plantuml.com">PlantUML</a>.</em></figcaption>
</figure>

Policies are classified by intent:

| Type | Policies | Behaviour |
|---|---|---|
| **Hard gates** (deny-only) | Sensitivity, SharingScope | Can deny but never allow — they protect boundaries |
| **Allow refiners** | Role, Ownership, WorkspaceScope, GroupScope | Can grant access but never override a deny |

A hard gate for data sensitivity means that even if you're a tenant admin, you can't read a `privileged`-classified resource without active elevation. The policy doesn't know or care about roles — it enforces classification, full stop.

### Tamper-Evident Audit Logging

Audit logs that can be silently edited aren't audit logs. They're wish lists.

Our `FluentAuditLogger` maintains a per-tenant SHA-256 hash chain. Each audit event's hash includes the previous event's hash, creating a blockchain-like chain per organisation. If someone modifies or deletes an event in the middle, the chain breaks — and `verifyChain(organizationId:)` returns `false`.

The chain is per-tenant, not global. Organisation A's audit trail is independent of Organisation B's. A chain verification for one tenant doesn't require reading every audit event in the system.

<figure>
  <img src="{{ '/assets/diagrams/rendered/audit-hash-chain.svg' | relative_url }}" alt="Per-tenant SHA-256 audit hash chains: each organisation maintains an independent append-only chain" style="width: 100%; max-width: 800px;">
  <figcaption>Independent hash chains per tenant. Tampering with any event breaks the chain from that point forward. <em>Rendered with <a href="https://d2lang.com">D2</a>.</em></figcaption>
</figure>

When the database write fails — network issue, disk full, whatever — the logger falls back to console output rather than silently dropping events. You can lose formatting. You can't lose the record that something happened.

### Tenant Isolation at the Data Layer

OWASP's multi-tenant guidance is clear: tenant isolation must be enforced at the data access layer, not just in middleware. A middleware that checks "is this user in tenant A?" is necessary but not sufficient — a controller that runs a raw Fluent query can still return tenant B's data.

`TenantScopedRepository` solves this by wrapping Fluent queries with an automatic `organizationId` filter. Controllers use the repository instead of raw queries. The scope is structural — you can't forget to add the filter because the repository adds it for you.

```swift
let repo = TenantScopedRepository<UserModel>(tenant: req.resolvedTenantContext)
let users = try await repo.query(on: req.db).all()
// Only returns users in the current tenant — always
```

<figure>
  <img src="{{ '/assets/diagrams/rendered/tenant-isolation.svg' | relative_url }}" alt="Multi-layer tenant isolation: middleware resolves tenant, policies enforce scope, repository auto-filters queries" style="width: 100%; max-width: 700px;">
  <figcaption>Three layers of tenant isolation. Even if middleware and policies pass, the repository enforces scoping at the query level. <em>Rendered with <a href="https://d2lang.com">D2</a>.</em></figcaption>
</figure>

Cross-tenant access attempts don't throw an error — they return no results. From the controller's perspective, users in other tenants simply don't exist. This is the right semantic for multi-tenant data: not "you can't access this" but "this doesn't exist in your world."

### The AUTH_MODE Contract

Development and production have fundamentally different authentication needs. In development, you want to test authorization logic without running an OIDC provider. In production, you want mandatory authentication with no backdoors.

We solved this with an environment variable — `AUTH_MODE` — that switches between three modes with zero code changes:

| Mode | What Happens |
|---|---|
| `disabled` | Four seeded demo principals with realistic role sets. The entire authorization pipeline still runs — you're testing real policies against fake identities |
| `optional` | JWT resolved if present, demo identity if not. Useful for staging environments where some users are authenticated and some aren't |
| `required` | 401 on unauthenticated requests. Full OIDC flow. Production mode |

The key insight: `disabled` mode doesn't bypass security. It provides known identities so the authorization pipeline runs fully. You're testing the policies, not just testing that your login form works.

## The Toolchain: How We Actually Built This

The framework took three phases over five days. That speed came from the toolchain as much as the code.

### Claude as Pair Programmer

Claude wrote code in this project — the co-author tag is on every commit. But the more interesting pattern was **plan refinement** — using Claude and Perplexity together to validate architectural decisions before writing a line of code.

The workflow: we'd describe an architectural question to Claude — "how should deny-precedence work when policies can abstain?" — and get a detailed proposal. Then we'd take the same question to Perplexity with a different framing: "what are the failure modes of order-independent policy evaluation in RBAC systems?" Perplexity returns academic papers, OWASP guidance, real-world CVEs from systems that got this wrong.

The two tools have complementary blind spots. Claude is excellent at generating coherent designs but can be confidently wrong about edge cases it hasn't seen. Perplexity surfaces real-world evidence — papers, CVEs, production incident reports — but doesn't synthesise them into a design. Using both, iteratively, produces better architecture than either alone.

Concrete example: Claude's initial proposal for the audit hash chain used a global chain — every event hashed against the previous global event. Perplexity surfaced a paper on audit log scalability that showed global chains become a serialisation bottleneck under concurrent writes. We switched to per-tenant chains before writing the code. That's a design decision that would have been expensive to change after implementation and invisible in testing until production load exposed it.

We ran this loop — Claude proposes, Perplexity validates, Claude revises — for every significant architectural decision: middleware ordering, policy classification, session rotation, CSRF token generation. The plan was solid before the first `swift build`.

<figure>
  <img src="{{ '/assets/diagrams/rendered/toolchain-workflow.svg' | relative_url }}" alt="Development toolchain: Claude proposes, Perplexity validates, gstack tests, atomic commits" style="width: 100%; max-width: 800px;">
  <figcaption>The full development loop. Plan refinement (top) feeds validated architecture into implementation (bottom). <em>Rendered with <a href="https://plantuml.com">PlantUML</a>.</em></figcaption>
</figure>

### gstack for QA and Development Workflow

We use gstack — a headless browser toolkit integrated with Claude Code — throughout development. Not just for final QA, but as part of the development loop.

The pattern: write a feature, deploy locally, use `/qa` to systematically test the feature against a checklist, get a structured bug report with screenshots, fix the bugs with before/after evidence. Each fix is an atomic commit. The QA cycle catches things that unit tests miss — rendering issues, middleware ordering effects on actual HTTP responses, CSRF token flow through real form submissions.

<figure>
  <img src="{{ '/assets/diagrams/rendered/oidc-flow.svg' | relative_url }}" alt="OIDC authentication flow with PKCE S256: login, redirect, token exchange, session creation, and dual-key validation" style="width: 100%; max-width: 750px;">
  <figcaption>The complete OIDC flow. PKCE S256 eliminates the need for a client secret on public clients. Dual-key session rotation keeps old sessions valid during key changes. <em>Rendered with <a href="https://plantuml.com">PlantUML</a>.</em></figcaption>
</figure>

For the OIDC flow specifically, gstack was invaluable. OIDC involves redirects, state parameters, PKCE challenge/verifier pairs, and cookie handling that's nearly impossible to test with unit tests alone. We used `/browse` to walk through the entire login → callback → session → logout flow in a real browser, capturing screenshots at each step. When the PKCE verifier wasn't being stored correctly in the session, the browser test caught it immediately — the unit test had passed because it was mocking the session storage.

The `/review` skill runs before every PR — analysing the diff for SQL safety issues, trust boundary violations, and structural problems. It caught a case where a controller was using a raw Fluent query instead of `TenantScopedRepository` — a tenant isolation violation that would have been invisible in code review because the query was syntactically correct.

## What We Shipped

Three phases, five commits, 45 tests passing with zero warnings:

| Phase | What | Key Files |
|---|---|---|
| **1. Security Chassis** | Middleware pipeline, principal resolution, rate limiting | 6 middleware files, SecurityKit entry point |
| **2. OIDC + Sessions** | Full OIDC with PKCE, dual-key session management, CSRF | OIDCController, SessionManager, PKCEGenerator |
| **3. Models + Policies + Audit** | 8 Fluent models, 6 authorization policies, hash-chain audit logger | CompositePolicy, FluentAuditLogger, TenantScopedRepository |

The framework is Apache 2.0 licensed. Any Vapor application can import it and get the full enterprise security chassis — the same one we're using for our own production applications.

## What's Still Missing

We're honest about what isn't built yet:

**Leaf templates** — the `Resources/Views/` directory is empty. The CSRF middleware generates tokens and makes them available via `req.csrfToken`, but the actual Leaf templates for the reference application (login screens, dashboards, admin panels) haven't been built. That's Phase 4.

**HTMX integration** — the CSRF middleware supports HTMX headers (`X-CSRF-Token`), but the front-end layer using Pico CSS + HTMX is planned, not shipped.

**Database triggers** — the audit logger enforces append-only semantics in application code, but the SQL triggers that prevent `UPDATE`/`DELETE` at the database level aren't in the migration yet. Application-level enforcement is necessary but not sufficient.

**Privilege elevation flow** — `SensitivityPolicy` returns `.elevationRequired` for privileged resources, and there's a `PrivilegeElevationModel` in the schema, but the actual elevation UI and approval workflow aren't implemented.

## The Broader Observation

Server-side Swift is mature enough for production web applications. The language's concurrency model, type safety, and performance characteristics are genuine advantages over Node.js and Rails for security-sensitive work. What's missing isn't capability — it's the reusable building blocks that other ecosystems take for granted.

Django ships with authentication, authorization, CSRF protection, and an admin panel. Rails has Devise, Pundit, and paper\_trail. Spring has Spring Security. Vapor has JWT verification and session middleware — and then you're on your own.

VaporSecurityKit is our attempt to close that gap. Not for every Vapor application — a blog doesn't need deny-precedence policy composition. But for the applications that handle sensitive data, serve multiple tenants, and need to pass a security review? The chassis should exist as a package, not as tribal knowledge.

---

*Sailesh Panchal is Director at Digital Transformation Advisory (DTA), specialising in technology strategy and AI-native architecture for enterprise clients.*
