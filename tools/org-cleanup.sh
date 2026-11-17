#!/usr/bin/env bash
# One-off cleanup of the fsharp-wasm organisation, after the history rewrite of 2026-11-15.
# Run it once, logged in to the GitHub CLI as an organisation owner (`gh auth login`).
set -euo pipefail
org=fsharp-wasm
own=(fsharp-wasm fsharp-wasm-core fsharp-wasm-runtime fsharp-wasm-graphics fsharp-glyph-aura fsharp-wasm-ide
     fsharp-wasm-backend fsharp-wasm-edge fsharp-wasmecto fsharp-wasm.github.io .github)
forks=(fsharp Fable)

# 1. default branches: main for our own repositories, develop for the two forks (main there mirrors upstream)
for r in "${own[@]}";   do gh repo edit "$org/$r" --default-branch main;    done
for r in "${forks[@]}"; do gh repo edit "$org/$r" --default-branch develop; done

# 2. delete every branch except develop and main (the backup/* branches stay until you have checked the history)
for r in "${own[@]}" "${forks[@]}"; do
  gh api --paginate "repos/$org/$r/branches?per_page=100" --jq '.[].name' \
    | grep -vxE 'develop|main|backup/.*' \
    | while read -r b; do gh api -X DELETE "repos/$org/$r/git/refs/heads/$b" >/dev/null && echo "deleted $r: $b"; done
done

# 3. move the two compiler tags (and so the releases) onto the rewritten history
gh api -X PATCH "repos/$org/fsharp-wasm/git/refs/tags/v0.1-experimental"        -f sha=01a40f1d47fad839548355fe87345307bbbd3a81 -F force=true
gh api -X PATCH "repos/$org/fsharp-wasm/git/refs/tags/v0.1.24-experimental"     -f sha=eb21ef9952eb952d6f7ed7f779322e59ee606e5d -F force=true

# 4. LATER, once the rewritten history is checked: remove the backups of the old history
# for r in "${own[@]}" "${forks[@]}"; do for b in develop main; do gh api -X DELETE "repos/$org/$r/git/refs/heads/backup/pre-rewrite-$b" 2>/dev/null || true; done; done
