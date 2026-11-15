# Security policy

fsharp-wasm is experimental software. It is a compiler, libraries and hosts, not a service, and there is no supported release line: the supported version is the latest
`develop` of each repository.

## Reporting a vulnerability

Please report it **privately**, not in a public issue:

1. open the repository on GitHub, choose **Security → Report a vulnerability** (GitHub's private vulnerability reporting), and describe what you found, how to
   reproduce it and what it affects;
2. if a repository does not offer that, open a private security advisory draft in the [compiler repository](https://github.com/fsharp-wasm/fsharp-wasm/security/advisories/new), or
   message an organisation owner on GitHub ([@aiqs4](https://github.com/aiqs4)) without details and ask for a private channel.

We will acknowledge a report within a week and tell you what we found and when to expect a fix. We will credit you in the fix unless you prefer not.

## What counts

A flaw in what we ship: the compiler producing a module that violates WebAssembly's guarantees, a host that lets a module reach what it should not, a dependency we pin that
is known to be vulnerable, a workflow that leaks a secret. A bug that only crashes your own program is an ordinary issue.
