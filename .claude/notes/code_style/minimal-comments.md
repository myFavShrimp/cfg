---
name: Don't add explanatory comments
description: Default to no comments — only add one when the WHY is non-obvious
type: feedback
---

Do not add comments that describe what the code does. Variable names, function names, and the code itself already convey that.

**When a comment is appropriate:** a hidden constraint, a non-obvious workaround, or a subtle invariant that a future reader would otherwise miss. Keep it short.

**Specifically: never document the absence of a feature.** Don't write "no JSON output for this command" or "this CLI doesn't support X" — readers wouldn't assume the missing thing exists, so the comment adds zero signal.
