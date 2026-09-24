# Sourced by every check that reads _site/.
#
# A downstream verification has no standing unless the artefact it examines
# can be shown to have been produced by the build under test. On 25 Sep 2026 a
# broken bundler left yesterday's _site in place and three checks "passed"
# against it. scripts/build-site.sh now deletes _site, builds, and stamps
# _site/.built-from with the commit it built and whether the tree was dirty;
# this helper refuses to verify anything else.
require_fresh_build() {
  local stamp="_site/.built-from" built dirty head
  if [ ! -f "$stamp" ]; then
    echo "no build stamp: _site was not produced by scripts/build-site.sh; a leftover _site is not evidence"
    exit 2
  fi
  built=$(sed -n '1p' "$stamp"); dirty=$(sed -n '2p' "$stamp"); head=$(git rev-parse HEAD)
  if [ "$built" != "$head" ]; then
    echo "stale _site: built from ${built:0:7}, HEAD is ${head:0:7}; run scripts/build-site.sh"
    exit 2
  fi
  [ "$dirty" = "dirty" ] && echo "  review: _site was built at ${head:0:7} from a tree with uncommitted changes"
  return 0
}
