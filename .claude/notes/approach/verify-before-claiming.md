---
name: Verify before claiming
description: Don't claim flags, behavior, or APIs exist without verifying; admit mistakes plainly when wrong
type: feedback
---

Before stating that a CLI flag, library function, API endpoint, or behavior exists, verify it against the actual source/docs. Do not extrapolate from sibling commands or from prior knowledge of similar tools.

**Examples of bad inference to avoid:**

- "`agent get` accepts `--output json`, so `agent list` must too." — flag definitions are per-command; check each.
- "Most CLIs follow `<verb> <noun>`, so `tool delete user` should work." — check the actual command tree.
- "This library probably has a `from_path()` constructor." — read the docs.

**When wrong, name it.** A fix that supersedes a wrong claim is not a "workaround." It is the correct call, and the previous one was wrong. Saying "switching to X as a workaround" implies the original was reasonable; admit it wasn't.

**How to apply:**

- For uncertain CLI behavior: run `--help`, read the cobra/clap definition, or check the source.
- For uncertain library APIs: read the docs or grep the source.
- When a tool fails because a flag/method doesn't exist: phrase the correction as "I was wrong about X. The correct call is Y."
