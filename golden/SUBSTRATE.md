# Renode substrate notes

Observations about the **host**, not the machine. Nothing here overrides
[`CONTRACT.md`](CONTRACT.md) or [`DECISIONS.md`](DECISIONS.md); D8 still fixes
the plugin's target framework at `net8.0`, and the reasons below are why.

## The plugin targets Renode's own framework (`net8.0`)

Renode 1.17 ships .NET 8: its `Renode.runtimeconfig.json` declares `net8.0` and
the portable package bundles runtime 8.0.12. A plugin shares the host's
assemblies, so it is built against the same API surface (D8).

## Tested: a newer target framework is not rejected at load time

On 2026-11-05 the model source was built as a throwaway `net10.0` assembly
against Renode's `net8.0` `Infrastructure.dll`, then loaded into Renode 1.17:

- **build**: succeeded; the assembly reports `.NETCoreApp,Version=v10.0`.
- **load**: succeeded; the plugin's constructor ran.
- **executing runtime**, as reported by `RuntimeInformation.FrameworkDescription`
  from inside the plugin: `.NET 8.0.12`.

The experimental copy logged a distinct message, so this was demonstrably the
`net10.0` build and not a leftover `net8.0` one.

**Why:** .NET unifies framework assemblies. A reference to
`System.Runtime, Version=10.0.0.0` binds to whatever framework is running, so
for a *library* the target framework in metadata is not a load gate (it is for
an application host).

**Why this is still a trap:** the mismatch is deferred, not prevented. The first
call to an API that does not exist in 8.0 raises `MissingMethodException` or
`TypeLoadException` at execution time — possibly long after start-up and only on
one code path. Compiling against 10 also silences the compiler, because the
newer reference assemblies advertise those APIs. A wrong target framework
therefore converts a start-up failure into a latent one, which is worse.

## Reproducing the experiment

Do it in `build/` (gitignored), never on the real project:

1. copy `model/Dolunay.cs` into a throwaway directory;
2. give that directory its own `global.json` pinning a newer SDK, because
   `golden/global.json` deliberately pins 8.0.x;
3. set `RENODE_BIN` and build it with `TargetFramework` changed;
4. copy the produced DLL into Renode's installation directory, name it in
   `[plugins] enabled-plugins`, run, then remove it again.

## If a later framework is ever needed

- Upgrade Renode first. The plugin's target framework follows the Renode
  runtime, not the other way round.
- A library that does not support `net8.0` is a **finding to report**, not a
  reason to raise the target silently. `AGENTS.md` §3 applies, and any change
  needs a decision.
- Do not treat "it loads anyway" as evidence of compatibility: it only shows
  that the APIs used so far exist in both frameworks.

## Other host behaviour worth not rediscovering

- Plugins are discovered by scanning Renode's **installation directory**,
  non-recursively, and only types under an `Antmicro.Renode.*` namespace are
  considered.
- Discovery is not enablement: `[plugins] enabled-plugins` must name the
  plugin, and `--config <file>` applies that for a single run.
- In a `--config` file, comments must start with `;`. Renode 1.17 hangs on `#`.
- Machine setup (toolchain, shims, editor) lives in `ENVIRONMENT.md` at the
  repository root, not here.
