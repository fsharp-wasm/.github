**Write F#. Ship WebAssembly GC. Run it in the browser and on the edge.**

fsharp-wasm compiles F# to [WebAssembly GC](https://github.com/WebAssembly/gc) — small modules that use the engine's own garbage collector —
and builds the libraries, tools and hosts around it. It is **experimental**: things here work and are measured, and we say plainly what is not done.

👉 **[fsharp-wasm.github.io](https://fsharp-wasm.github.io)** — the site, the live demos and the [benchmarks](https://fsharp-wasm.github.io/benchmarks/)

---

## ✅ What works today

- **A compiler** from F# to WasmGC (a modern WAT/binary back end behind a forked [Fable](https://github.com/fsharp-wasm/fable) front end).
- **Small modules**: 12–153 KB raw, 4–45 KB with brotli, for whole demo applications.
- **Speed, measured** (one 4-vCPU machine, 13 kernels, F# against hand-written JavaScript): on V8 the F# module is faster in 9–11 of the 13, geometric
  mean 1.45–1.58× without the one kernel the compiler fuses into a single loop; on JavaScriptCore 1.03×. Part of the V8 result is V8's inliner.
  Every number, the method and what is *not* measured: [benchmarks](https://fsharp-wasm.github.io/benchmarks/).
- **One backend module on six platforms**: the same F# program answers identically on Node, Bun, Deno, Cloudflare Workers (with a Durable Object),
  Vercel and Netlify in our test matrix. It is not deployed to those platforms yet — [fsharp-wasm-backend](https://github.com/fsharp-wasm/fsharp-wasm-backend) says what is a runtime and what an emulation.

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
| **[fsharp-wasm-edge](https://github.com/fsharp-wasm/fsharp-wasm-edge)** | *New, just started.* The host that will run those modules on Cloudflare, Vercel, Netlify, Deno, Bun and Node — today that code lives in the backend repository |
| **[fsharp-wasmecto](https://github.com/fsharp-wasm/fsharp-wasmecto)** | An Expecto-style test framework compiled to WasmGC |
| [fsharp](https://github.com/fsharp-wasm/fsharp) · [fable](https://github.com/fsharp-wasm/fable) | Forks (MIT) the compiler builds on |

## 🧭 Where it is going

Planned, not done — we list what exists and what is intended apart:

- **Backend modules as WebAssembly components** (WIT worlds), linked by a small host on every edge platform.
- **A typed F# DSL** for that host, usable from [Fable](https://fable.io) projects.
- **A GUI framework that renders real, accessible HTML** — semantic elements, keyboard and screen-reader support — beside the canvas graphics.
  Not everything can be WebAssembly drawing pixels; what people read and operate has to be accessible.
- Less .NET, more of our own libraries: independence from what the platform happens to ship.

## 🤝 Join in

We are early, so the work you do shapes the direction. Good places to start: a failing program (an
[issue](https://github.com/fsharp-wasm/fsharp-wasm/issues) with the F# source is the best bug report), a benchmark we should add, a platform we should
run on, documentation. Questions and ideas are welcome as issues too.

Everything we wrote is Apache-2.0 (the two forks stay MIT).
