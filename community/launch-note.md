# Launch note (draft)

A draft, not posted anywhere. Outlets, wording and date are the maintainer's decision. Everything below is a measurement with its date; what was not measured is said as such.
Replace the dates and re-run the commands before the post goes out: a number that is a week old is not a launch number.

---

## Title

fsharp-wasm: F# compiled to WebAssembly GC, with a library stack and a test framework that run the same code on .NET and in the browser

## Text

fsharp-wasm compiles ordinary F# projects to WebAssembly GC. The project is an `.fsproj`, `dotnet build` builds it, and `fsharp-wasm . --outDir out` produces the module; the same code runs
under .NET and as WebAssembly, and the suites run it both ways and compare.

**What you can run today (2026-11-27)**

- Getting started, from nothing to a running module, in four commands: `dotnet tool install -g FSharp.Wasm.Cli --prerelease`, `dotnet new install FSharp.Wasm.Templates`,
  `dotnet new fsharp-wasm -o hello`, `fsharp-wasm . --outDir out`. Run in an empty home folder against nuget.org on Linux; the compile took 4.9 s. macOS and Windows are not checked yet
  (that is the first open issue, and the first one we would like help with).
- Libraries as NuGet packages, version 0.1.0-preview: the base library, JSON, typed CSS and HTML, editing operations, columnar tables, a data graph, charts, diagrams and widgets.
  A program that uses `FSharp.Wasm.Data` from nuget.org compiles and runs (`total ()` is 19 in the guide).
- Demos in the browser, each a few hundred kilobytes of WebAssembly: charts (400 000 points, a live histogram on the data graph), the widget editor, an accounting grid of a million lines, WasmOS.
- A server module (Ghost Todo, 47 KB of WebAssembly GC) on Cloudflare Workers with a Durable Object: all 29 checks of the test matrix pass against the live address. On Vercel and Netlify it is
  deployed, the page answers and the API waits for a shared store; it is not shown there yet.
- The compiler's status page lists what passes: 729 QuickTests of the compiler's own suite, and sibling programs (the base library, the newsletter designer, the widget editor, the graphics libraries,
  a terminal UI) that are compiled and run on every change.

**What does not work yet** (the full list, with a program for each, is `docs/STATUS.md`): `sprintf "%A"`, dictionary literals, a lazy `seq` (it is a strict list), `async`, exceptions that carry a
payload cannot be caught by type, `System.String(char[])`, letters beyond ASCII in `Char.IsLetter`. The accessibility of the canvas widgets is under way and measured (0 violations by axe, and
one unnamed canvas to a screen reader: the document says why that is the problem).

**Where it is going** — one line: an F# compiler for WebAssembly GC and a stack on it, with every fault of the stack fixed in the compiler rather than worked around in a library. Apache-2.0. The work is
funded by sponsors; the plan and the numbers are on the sponsor page.

## Links

Site · getting started · compiler repository · status page · demos · sponsor page · good first issues (`community/good-first-issues.md`)

## Before it goes out (checklist)

- [ ] Getting started re-run from an empty home on Linux the same day; the date in the guide's header is today's.
- [ ] `docs/STATUS.md` read, the numbers above re-measured (the QuickTest count, the suites, the live check against Cloudflare).
- [ ] Vercel and Netlify: either the Redis variables are set and the live check passes there, or the text keeps saying "deployed, API waits for a shared store".
- [ ] The good first issues are filed (the maintainer's go), with the label `good first issue`; the discussion board is on.
- [ ] Secret scan of the histories (done 2026-11-27 over every ref of the 17 own repositories: no credentials found by pattern) and GitHub's secret scanning with push protection switched on for the organisation (a setting of the organisation, the maintainer's to switch).
- [ ] Nobody is promised anything that the status page does not show.
