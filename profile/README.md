**Write F#. Ship WebAssembly GC. Run it in the browser and on the edge.**

fsharp-wasm compiles F# to [WebAssembly GC](https://github.com/WebAssembly/gc) — small modules that use the engine's own garbage collector —
and builds the libraries, tools and hosts around it. It is **experimental**: things here work and are measured, and we say plainly what is not done.

👉 **[fsharp-wasm.github.io](https://fsharp-wasm.github.io)** — the site, the live demos and the [benchmarks](https://fsharp-wasm.github.io/benchmarks/)

---

## ✅ What works today

- **A compiler** from F# to WasmGC (a WAT printer and a binary encoder behind a forked [Fable](https://github.com/fsharp-wasm/fable) front end), with 675 regression tests and a differential run against .NET of 183 012 calls without a disagreement.
- **Small modules**: 12–153 KB raw, 4–45 KB with brotli, for whole demo applications.
- **Speed, measured** (one 4-vCPU machine, 13 kernels, F# against hand-written JavaScript): on V8 the F# module is faster in 9–11 of the 13, geometric
  mean 1.45–1.58× without the one kernel the compiler fuses into a single loop; on JavaScriptCore 1.03×. Part of the V8 result is V8's inliner.
  Every number, the method and what is *not* measured: [benchmarks](https://fsharp-wasm.github.io/benchmarks/).
- **One backend module on six platforms**: the same F# program answers identically on Node, Bun, Deno, Cloudflare Workers (with a Durable Object),
  Vercel and Netlify in our test matrix. It is not deployed to those platforms yet — [fsharp-wasm-edge](https://github.com/fsharp-wasm/fsharp-wasm-edge) says what is a runtime and what an emulation.

## 🔎 See it, run it, check it

| | |
|---|---|
| **[Live demos](https://fsharp-wasm.github.io/demos)** | Demos that run in your browser: a counter, a todo list, a Web Worker actor, a canvas scene gallery, a widget editor, a benchmark |
| **[Examples](https://fsharp-wasm.github.io/examples)** | Code to read and run: classic algorithms, component linking, a server module, graphics, text shaping |
| **[Benchmarks](https://fsharp-wasm.github.io/benchmarks)** | Thirteen kernels against JavaScript, the size of every module, load times on five networks — with the method and what is not measured |
| **[Tests](https://fsharp-wasm.github.io/tests)** | Every suite of every repository: what it checks, how many tests, how to run it, whether CI runs it |
| **[Backend on the edge](https://fsharp-wasm.github.io/backend)** | The same F# module on eight test targets, and the honest status: not deployed yet |

## 🧱 Projects

| | |
|---|---|
| **[fsharp-wasm](https://github.com/fsharp-wasm/fsharp-wasm)** | The compiler: F# → WebAssembly GC |
| **[fsharp-wasm-core](https://github.com/fsharp-wasm/fsharp-wasm-core)** | The F# base library of compiled programs — source-only, our own types instead of the .NET BCL |
| **[fsharp-wasm-runtime](https://github.com/fsharp-wasm/fsharp-wasm-runtime)** | The browser runtime, the demos and the public benchmarks |
| **[fsharp-wasm-graphics](https://github.com/fsharp-wasm/fsharp-wasm-graphics)** | A retained-mode 2D graphics stack: scene graph, widgets, a TEA runtime |
| **[fsharp-glyph-aura](https://github.com/fsharp-wasm/fsharp-glyph-aura)** | OpenType shaping and SDF text layout, zero-alloc |
| **[fsharp-wasm-ide](https://github.com/fsharp-wasm/fsharp-wasm-ide)** | Tools written in F#: the visual widget editor first |
| **[fsharp-wasm-backend](https://github.com/fsharp-wasm/fsharp-wasm-backend)** | Backend modules in F# (the *Ghost Todo* demo) and the .NET reference libraries |
| **[fsharp-wasm-edge](https://github.com/fsharp-wasm/fsharp-wasm-edge)** | The host that runs those modules on Cloudflare, Vercel, Netlify, Deno, Bun and Node: the core, the adapters, the platform matrix and the deploy workflow. *New; not deployed yet* |
| **[fsharp-wasm-newsletter](https://github.com/fsharp-wasm/fsharp-wasm-newsletter)** | A newsletter designer in F#: blocks to HTML email, web version and plain text, Bootstrap 5.3 by default and configurable. *New; the email is not yet tested in real mail clients* |
| **[fsharp-wasm-accounting](https://github.com/fsharp-wasm/fsharp-wasm-accounting)** | An accounting grid: a ledger of a million journal lines as a pivot table that folds to its totals, turns and drills down. *New.* |
| **[fsharp-wasm-sci](https://github.com/fsharp-wasm/fsharp-wasm-sci)** | Scientific computing: linear algebra, geospatial, chemistry, quantum simulation. *Planned; no code yet.* |
| **[fsharp-wasm-embedded](https://github.com/fsharp-wasm/fsharp-wasm-embedded)** | The universal shell: one app on the desktop (Windows, macOS, Linux) and on phones (iOS, Android). *Planned; the first piece is a page that tells what a device's web view can run.* |
| **[fsharp-wasm-mobile](https://github.com/fsharp-wasm/fsharp-wasm-mobile)** | The device APIs for those apps (haptics, share, secure storage, deep links, camera, …), web first and native where the web has nothing; television later. *Planned; the catalogue and the contract are drafted.* |
| **[fsharp-wasmecto](https://github.com/fsharp-wasm/fsharp-wasmecto)** | An Expecto-style test framework compiled to WasmGC |
| [fsharp](https://github.com/fsharp-wasm/fsharp) · [fable](https://github.com/fsharp-wasm/fable) | Forks (MIT) the compiler builds on |

## 🧭 Where it is going

Planned, not done — we list what exists and what is intended apart. The order and the reasons are in the [roadmap](https://fsharp-wasm.github.io/docs/roadmap/), and every project, with what works today, is on the [projects page](https://fsharp-wasm.github.io/projects/).

- **Speed that keeps the writing pleasant**: builders and small DSLs stay, and the compiler takes their cost away. A bulk path for strings across the host boundary is done (measured: the state of 5 000 todos 20.6 ms to 6.2 ms on Node); the compiled code for long strings and the builders are next.
- **A pre-compiler at build time** for the scene graph and for GlyphAura, so that a program carries only the scene elements, widgets and glyph data it uses.
- **Editors that are a pleasure to use**: the widget editor and the newsletter designer.
- **A spreadsheet grid with formulas** ([fsharp-wasm-accounting](https://github.com/fsharp-wasm/fsharp-wasm-accounting)): the first version runs as a demo (a million journal lines turned in 4 to 5 ms, measured 2026-11-24 in a headless Chromium); formulas over measures and the tree of a chart of accounts come next.
- **Apps on phones and desktops**: a shell ([fsharp-wasm-embedded](https://github.com/fsharp-wasm/fsharp-wasm-embedded)) and the device APIs ([fsharp-wasm-mobile](https://github.com/fsharp-wasm/fsharp-wasm-mobile)); television later. The first question is which web views can run our modules at all, and the probe in the shell's repository asks it: [send a device report](https://github.com/fsharp-wasm/fsharp-wasm-embedded/issues/new?template=device_report.yml).
- **A data science library** in the manner of NumPy and Polars, and **WIT with Rust libraries**, so that what exists in Rust is not written twice.
- **Real deployments** of the Ghost Todo on Cloudflare, Vercel and Netlify.
- **A GUI layer that renders real, accessible HTML** — semantic elements, keyboard and screen-reader support — beside the canvas graphics.
- Less .NET, more of our own libraries: independence from what the platform happens to ship.

## 💛 Sponsor the organisation

The work across all of these repositories is supported through [GitHub Sponsors: fsharp-wasm](https://github.com/sponsors/fsharp-wasm).

## 🤝 Join in

We are early, so the work you do shapes the direction. Good places to start: a failing program (an
[issue](https://github.com/fsharp-wasm/fsharp-wasm/issues) with the F# source is the best bug report), a benchmark we should add, a platform we should
run on, documentation. Questions and ideas are welcome in discussions and as issues; [CONTRIBUTING](https://github.com/fsharp-wasm/.github/blob/main/CONTRIBUTING.md) says how.

Everything we wrote is Apache-2.0 (the two forks stay MIT).
