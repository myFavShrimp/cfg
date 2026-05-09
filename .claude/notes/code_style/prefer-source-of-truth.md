---
name: Prefer the authoritative source over heuristics
description: Don't infer information from filename/extension/naming patterns when the real source of truth is queryable
type: feedback
---

Never use heuristics to infer information that can be queried directly from the authoritative source.

**Examples:**

- Determining whether a path is a file or a directory: query the filesystem (`std::fs::metadata`, `tokio::fs::metadata`, `os.stat`, etc.). Don't check whether the path has an extension.
- Determining a file's content type: read the magic bytes or query the OS. Don't trust the extension.
- Determining whether a binary is installed: `which` / `exec.LookPath`. Don't check predictable install paths.
- Determining whether a CLI flag exists: read the command's source/help. Don't extrapolate from sibling commands.

**How to apply:** when tempted to infer X from a name, path, or sibling, stop and ask whether X is directly queryable. Almost always it is. Use the query.
