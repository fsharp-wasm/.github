# Contributing to fsharp-wasm

Thank you for looking. fsharp-wasm is an open-source organisation that compiles F# to WebAssembly GC and builds the libraries, hosts and tools around it. It is
**experimental and early**, which means your work shapes the direction. This page is the default for every repository of the organisation; a repository may add its own.

## Where things are

| repository | what it is |
|---|---|
| [fsharp-wasm](https://github.com/fsharp-wasm/fsharp-wasm) | the compiler |
| [fsharp-wasm-core](https://github.com/fsharp-wasm/fsharp-wasm-core) | the F# base library of compiled programs |
| [fsharp-wasm-runtime](https://github.com/fsharp-wasm/fsharp-wasm-runtime) | the browser runtime, the demos and the benchmarks |
| [fsharp-wasm-edge](https://github.com/fsharp-wasm/fsharp-wasm-edge) | the host for Cloudflare, Vercel, Netlify, Deno, Bun and Node |
| [fsharp-wasm-backend](https://github.com/fsharp-wasm/fsharp-wasm-backend) | server modules in F# and the .NET reference libraries |
| [fsharp-wasm-graphics](https://github.com/fsharp-wasm/fsharp-wasm-graphics), [fsharp-glyph-aura](https://github.com/fsharp-wasm/fsharp-glyph-aura), [fsharp-wasm-ide](https://github.com/fsharp-wasm/fsharp-wasm-ide) | graphics, text shaping, the widget editor |
| [fsharp-wasmecto](https://github.com/fsharp-wasm/fsharp-wasmecto) | an Expecto-style test framework compiled to WebAssembly |
| [fsharp-wasm.github.io](https://github.com/fsharp-wasm/fsharp-wasm.github.io) | the website |
| [fsharp](https://github.com/fsharp-wasm/fsharp), [Fable](https://github.com/fsharp-wasm/Fable) | forks (MIT); read their `AGENTS.md` before touching a branch |

[fsharp-wasm.github.io/docs/getting-started](https://fsharp-wasm.github.io/docs/getting-started) takes you from nothing to a running module; the
[tests page](https://fsharp-wasm.github.io/tests) lists every suite and how to run it.

## Ways to help

- **A program that does not compile.** An issue with the F# source is the best bug report we get: it becomes a test. The known gaps are listed in the compiler's
  [docs/STATUS.md](https://github.com/fsharp-wasm/fsharp-wasm/blob/main/docs/STATUS.md) — stepped ranges, array slices, a few `System.Array` methods, `sprintf "%A"` — and
  each is a good first task.
- **Tests that run everywhere.** Two compiler suites do not run at present; browser tests run in Chromium only. Firefox and Safari coverage is wanted.
- **Benchmarks and comparisons** — a kernel we should add, the same programs in Fable → JavaScript, Blazor or Kotlin/Wasm.
- **A platform** we should run on, or a real deployment of the host.
- **Accessibility.** A GUI layer that renders semantic HTML, and automated accessibility checks.
- **Documentation** — a page that confused you is a page to fix.

Issues labelled `good first issue` are the places to start.

## How to contribute a change

1. **Open an issue first** for anything larger than a fix, so that we can agree on the direction before you spend the time.
2. Fork the repository and cut a branch from `develop`. `develop` is where work happens; `main` is what has passed CI on `develop`.
3. Keep the change small and say why in the commit message. Add a test where there can be one: for the compiler, a case in `tests/QuickTest` or `tests/Showcase` that failed before.
4. Run the repository's tests (its README says how; the compiler's are `bash tests/run-all.sh`).
5. Open a pull request against `develop`. CI has to pass.

The forks (`fsharp`, `Fable`) keep `main` as a mirror of upstream and `develop` as our branch; changes that belong upstream go there as a pull request.

## Licence

By contributing you agree that your contribution is licensed under the licence of the repository it goes into (see that repository's `LICENSE` file): the
[Apache License 2.0](LICENSE) everywhere, except in the two forks the compiler is built on, Fable and the F# compiler, which keep their MIT License.

## Questions

Ask in a [discussion](https://github.com/fsharp-wasm/fsharp-wasm/discussions) or open an issue. See [SUPPORT.md](SUPPORT.md).
