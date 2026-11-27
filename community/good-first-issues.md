# Good-first-issue drafts

Drafts, not issues: nothing here is filed yet (an issue is outward-facing, and waits for the maintainer's go). Each one is small, has a program that shows it, says where to
look, and says when it is done. The compiler items were measured on **2026-11-27** with the released tool (`FSharp.Wasm.Cli 0.1.0-preview`) against .NET 10 (`dotnet fsi`).

Rules that apply to every one of them (they are in the contributors' guide too): a fault of the compiler is fixed **in the compiler**, never worked around in a library; **every fix has a
test that fails without it** (QuickTest: `tests/QuickTest/QuickTestWasmGc.fs` plus a `check(...)` line in `test-runner.mjs`); and `docs/STATUS.md` moves the item from the known gaps to the
dated list of what was closed.

---

## 1. `System.String(char[])` does not compile

**Repository:** fsharp-wasm · **labels:** `good first issue`, `compiler`, `bcl`

```fsharp
module gap
let fromChars () : int = (System.String([| 'a'; 'b'; 'c' |])).Length
```

Measured: `error[WGC008] in 'fromChars': Expression of non-Unit type compiled to Nop (produces no value): Emit`. On .NET the result is `3`.

**Where to look:** the other string helpers are in `src/Bcl/StringHelpers.fs` (see `makeStrTrimEndCharHelper`), registered in `src/Bcl/BclRegistry.fs` and chosen in
`src/Transforms/Fable2Wasm/TransformDispatch.fs` (the `"trimEnd"` case is a small example). The front end hands the constructor over as an `Emit`; find what it looks like in the Fable AST first.

**Done when:** `System.String(chars)` gives the string of the characters; a QuickTest compares it with the .NET value (also for an empty array); `String(c, count)` and `String(chars, start, length)`
are either done or written down as the next issue.

---

## 2. `Char.IsLetter`, `ToUpper` and friends know ASCII only

**Repository:** fsharp-wasm · **labels:** `good first issue`, `compiler`, `bcl`

```fsharp
module gap
let isLetterUmlaut () : bool = System.Char.IsLetter 'ä'
let upperUmlaut () : int = int (System.Char.ToUpper 'ä')
```

Measured: WebAssembly gives `false` and `228`; .NET gives `true` and `196` (`Ä`).

**Where to look:** `src/Bcl/CharHelpers.fs` (`makeCharIsLetterHelper` and the helpers beside it) — they test `A`..`Z` and `a`..`z`. The scope of this issue is **Latin-1 and Latin Extended-A**, not
all of Unicode: pick the ranges, and take care of the exceptions (`×` U+00D7 and `÷` U+00F7 are not letters; `ß` U+00DF has no single upper-case letter, .NET returns it unchanged).

**Done when:** `IsLetter`, `IsLetterOrDigit`, `IsUpper`, `IsLower`, `ToUpper` and `ToLower` agree with .NET for every character U+0000..U+017F (a QuickTest that loops over the range and counts
disagreements, so the test stays small), and the rest of Unicode is listed as a known gap.

---

## 3. `TrimEnd`, `TrimStart` and `Trim` with several characters

**Repository:** fsharp-wasm · **labels:** `good first issue`, `compiler`, `bcl`

```fsharp
module gap
let trimMany () : int = ("1.500".TrimEnd('0', '.')).Length
```

Measured: `warning[WGC002] Unhandled import call 'trimEnd'` and then `error[WGC008]`; .NET gives `3` (`"1.5"`). The form with **one** character works (`$strTrimEndChar`).

**Where to look:** the one-character helpers in `src/Bcl/StringHelpers.fs` and their dispatch in `TransformDispatch.fs`. The `params char[]` form arrives as an array; either a helper that takes
the array, or a loop over the single-character helper.

**Done when:** the three methods accept any number of characters, a QuickTest covers the empty set (nothing is trimmed) and a string that is trimmed away entirely.

---

## 4. Run the Getting started guide on macOS and on Windows

**Repository:** fsharp-wasm · **labels:** `good first issue`, `documentation`, `help wanted`

The [guide](https://fsharp-wasm.github.io/docs/getting-started) was run as written on Linux only, on 2026-11-27, and says so at the top. Run it on macOS or on Windows
(`dotnet tool install -g FSharp.Wasm.Cli --prerelease`, `dotnet new install FSharp.Wasm.Templates`, `dotnet new fsharp-wasm -o hello`, `fsharp-wasm . --outDir out`, `node run.mjs`) and report in
this issue: the operating system and its version, `dotnet --version`, `node --version`, and the output of the last command (expected: `fibonacci 10 = 55`, `isPrime 97, 100 = 1 0`,
`sum of odd squares 9 = 165`).

**Done when:** a comment with the three lines of output, or with the first command that failed and its message. A failure is a finding for us, not for you; we fix it and say on the page which
systems were checked and when.

---

## 5. The label of a `Gauge` is drawn on the default background

**Repository:** Amano.Tui · **labels:** `good first issue`, `bug`

Listed under "Known issues" in the README: the text on a `Gauge` takes the terminal's background, not the colour of the bar it lies on, so that on a coloured bar it is a box of a different colour.

**Where to look:** `src/Amano.Tui/Widgets/Gauge.fs`, and `tests/golden/` (the golden frames: a change of the drawing changes a frame on purpose, and the pull request says so).

**Done when:** the label keeps the style of the cell under it (the filled part and the empty part each), a test pins it, the golden frames are updated by `golden-update.yml` or by hand with the diff
explained, and the line leaves the README's "Known issues".

---

## 6. `Color` and `Ansi` both build the colour parameters

**Repository:** Amano.Tui · **labels:** `good first issue`, `refactor`

The README says it: both modules build the SGR colour parameters, and a test pins them to each other "until one goes". Make one of them the owner (`Ansi` is the one that writes, `Color` the one
that is used everywhere: decide, and say why), delete the other copy, and keep the test as a test of the one.

**Done when:** one function builds the parameters, the pinning test now checks known values (the 16 colours, a 256-colour index, a true colour), the golden frames do not change.

---

## 7. Run the accessibility baseline in CI

**Repository:** fsharp-wasm-graphics · **labels:** `good first issue`, `accessibility`, `ci`

`tools/a11y/baseline.mjs` measures a page with axe-core (WCAG 2.0 / 2.1 / 2.2, levels A and AA) and writes the result; `docs/accessibility.md` has the numbers of 2026-11-17. No workflow runs it.
The newsletter designer's end-to-end test already fails on an axe violation (`tests/e2e/designer.mjs` in fsharp-wasm-newsletter): use it as the example.

**Done when:** a job in `.github/workflows/ci.yml` runs the baseline against the gallery, compares the number of violations with a committed file, and fails when it grows; the page says what
the job checks and what it does not (a canvas passes axe, which is the point of the document).

---

*Bigger items that are welcome, but are not first issues:* `sprintf "%A"` and `%O` of a record, union, list or tuple; dictionary literals (`dict [ … ]`); comparer constructor overloads; a
lazy `seq` (today it is a strict list); an exception with a payload that can be caught by type. Each is in the compiler's [known gaps](https://github.com/fsharp-wasm/fsharp-wasm/blob/main/docs/STATUS.md)
with a program that shows it. Talk to us in an issue before you start.
