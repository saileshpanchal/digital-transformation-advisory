# Digital Transformation Advisory

A blog on technology strategy, Apple platform engineering, AI-native architecture, and the people shaping our digital future.

**Live:** [saileshpanchal.github.io/digital-transformation-advisory](https://saileshpanchal.github.io/digital-transformation-advisory)

## Stack

- **Jekyll** with GitHub Pages
- Deployed via GitHub Actions on push to `master`
- Minimal custom CSS, no theme dependency

## Writing Posts

Create files in `_posts/` with the format `YYYY-MM-DD-title.md`:

```yaml
---
title: "Your Post Title"
date: 2026-03-18
categories: [Technology, AI]
tags: [mlx, apple-silicon]
excerpt: "Brief summary."
---

Your markdown content here...
```

## Local Development

```bash
bundle install
bundle exec jekyll serve
```

Visit `http://localhost:4000/digital-transformation-advisory/`
