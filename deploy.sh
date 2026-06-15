#!/usr/bin/env bash
#
# deploy.sh — build the Jekyll site and publish it to the gh-pages branch.
#
# Why this exists: GitHub Pages for this repo serves from the `gh-pages` branch
# (Settings → Pages → "Deploy from branch"), and the Actions workflow that would
# normally build+deploy is blocked. Until Actions are unblocked AND Pages source
# is switched to "GitHub Actions", this script is the deploy path.
#
# Usage:  ./deploy.sh
#   Builds the CURRENT working tree (commit + push your changes to master first
#   if you want gh-pages to match master). Prints the source commit it deployed.
#
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$REPO_ROOT"

# macOS system Ruby 2.6 can't run bundler 4.x / Jekyll 4.3. Put Homebrew Ruby
# first on PATH so this works even in a non-login shell (mirrors ~/.zprofile).
if [ -d /opt/homebrew/opt/ruby/bin ]; then
  export PATH="/opt/homebrew/opt/ruby/bin:/opt/homebrew/lib/ruby/gems/4.0.0/bin:$PATH"
fi

SRC_COMMIT="$(git rev-parse --short HEAD)"
SRC_BRANCH="$(git rev-parse --abbrev-ref HEAD)"
echo "→ Building site from ${SRC_BRANCH} @ ${SRC_COMMIT}"

bundle install --quiet
JEKYLL_ENV=production bundle exec jekyll build

# Guard: the custom domain breaks if CNAME is missing from the published site.
if [ ! -s _site/CNAME ]; then
  echo "ABORT: _site/CNAME is missing — refusing to deploy (would drop the custom domain)." >&2
  exit 1
fi
echo "→ Built _site ($(cat _site/CNAME))"

# Publish _site to gh-pages via a throwaway worktree, reset to origin/gh-pages so
# we can never push a stale branch. Worktree is always cleaned up (trap).
WORKTREE="$(mktemp -d -t dta-ghpages.XXXXXX)"
cleanup() { git worktree remove --force "$WORKTREE" 2>/dev/null || true; }
trap cleanup EXIT

git fetch --quiet origin gh-pages
git worktree add --quiet --force -B gh-pages "$WORKTREE" origin/gh-pages

# Mirror _site into the worktree: --delete removes files dropped from the build;
# --exclude .git keeps the worktree's git metadata intact. CNAME rides along.
rsync -a --delete --exclude='.git' _site/ "$WORKTREE"/

# Serve the pre-built output as-is: .nojekyll stops GitHub Pages running its own
# Jekyll build on the branch (which can stall/fail and silently block publishing).
# Added after rsync because --delete would otherwise strip it.
touch "$WORKTREE/.nojekyll"

cd "$WORKTREE"
git add -A
if git diff --cached --quiet; then
  echo "→ No changes to deploy — gh-pages already matches the build."
  exit 0
fi

git commit --quiet -m "Deploy site to GitHub Pages (manual build from ${SRC_BRANCH} ${SRC_COMMIT})"
git push --quiet origin gh-pages
echo "✓ Deployed. Live at https://digital-transformation-advisory.com/ (allow ~1 min for CDN)."
