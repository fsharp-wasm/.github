#!/usr/bin/env bash
# The settings of the fsharp-wasm organisation's repositories that only an owner can set through the API: the About box
# (description, website, topics), private vulnerability reporting.  Idempotent.
#
#   DRY=1 bash tools/org-setup.sh     print what it would do
#   bash tools/org-setup.sh           do it (logged in to the GitHub CLI as an organisation owner: `gh auth login`)
#
# Not here, because the API has no call for them: the social preview image of a repository (Settings, General), GitHub
# Sponsors for the organisation (Settings, Sponsorship), the sponsor tiers.  Default branches and branch cleanup:
# tools/org-cleanup.sh.
set -euo pipefail
org=fsharp-wasm
site=https://fsharp-wasm.github.io
run() { if [ "${DRY:-0}" = 1 ]; then echo "+ $*"; else "$@"; fi; }

# repository | description | website | topics (comma separated); the two forks keep the description and website they have
repos=(
  "fsharp-wasm|F# to WebAssembly GC: small modules that use the engine's own garbage collector. Experimental.|$site|fsharp,webassembly,wasm,wasmgc,compiler,fable"
  "fsharp-wasm-core|The F# base library of programs compiled by fsharp-wasm: source-only, our own types instead of the .NET BCL.|$site|fsharp,webassembly,wasmgc,standard-library"
  "fsharp-wasm-runtime|Browser runtime, live demos and public benchmarks for F# compiled to WebAssembly GC.|$site/demos|fsharp,webassembly,wasmgc,benchmarks,browser"
  "fsharp-wasm-graphics|Retained-mode 2D graphics stack in F#: scene graph, widgets, TEA runtime. Compiles to WebAssembly GC.|$site|fsharp,webassembly,wasmgc,graphics,ui,canvas"
  "fsharp-glyph-aura|OpenType shaping and SDF text layout in F#, zero-alloc.|$site|fsharp,opentype,text-layout,sdf,webassembly"
  "fsharp-wasm-ide|Tools written in F# for F# on WebAssembly GC: the visual widget editor first.|$site/demos|fsharp,webassembly,wasmgc,editor,ui"
  "fsharp-wasm-backend|Backend modules in F# compiled to WebAssembly GC (the Ghost Todo demo) and the .NET reference libraries.|$site/backend|fsharp,webassembly,wasmgc,backend,edge"
  "fsharp-wasm-edge|The host that runs WebAssembly GC backend modules on Cloudflare, Vercel, Netlify, Deno, Bun and Node.|$site/backend|fsharp,webassembly,wasmgc,edge,cloudflare-workers,deno,bun"
  "fsharp-wasm-newsletter|A newsletter designer in F# on WebAssembly GC: HTML email, web version and plain text; Bootstrap 5.3 by default, configurable.|$site/demos|fsharp,webassembly,wasmgc,newsletter,email,bootstrap"
  "fsharp-wasmecto|An Expecto-style test framework compiled to WebAssembly GC.|$site|fsharp,testing,webassembly,wasmgc,expecto"
  "fsharp|||fsharp,compiler,fork"
  "Fable|||fsharp,fable,compiler,fork"
)

for entry in "${repos[@]}"; do
  IFS='|' read -r repo desc home topics <<<"$entry"
  echo "== $repo"
  [ -z "$desc" ] || run gh repo edit "$org/$repo" --description "$desc" --homepage "$home"
  # `gh repo edit --add-topic` adds; the API call replaces the list, which is what we want for a repeatable run
  names=$(printf '%s' "$topics" | python3 -c "import sys,json; print(json.dumps({'names': sys.stdin.read().split(',')}))")
  if [ "${DRY:-0}" = 1 ]; then echo "+ gh api -X PUT repos/$org/$repo/topics  $names"; else printf '%s' "$names" | gh api -X PUT "repos/$org/$repo/topics" --input - >/dev/null; fi
  run gh api -X PUT "repos/$org/$repo/private-vulnerability-reporting" --silent || echo "  (private vulnerability reporting: needs the repository to be public and you an admin)"
done

# Discussions: the compiler repository has them; the others point there from their issue templates.
run gh repo edit "$org/fsharp-wasm" --enable-discussions
echo "done"
