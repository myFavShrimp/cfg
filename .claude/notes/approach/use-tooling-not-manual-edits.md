---
name: Use the tool's CLI, not manual config edits
description: Add/remove dependencies, scaffold migrations, generate boilerplate via the official CLI — never hand-edit the underlying config files
type: feedback
---

When a tool provides a CLI to mutate its config, use the CLI. Do not hand-edit the underlying file.

**Examples:**

- **Rust dependencies:** `cargo add <crate>` / `cargo remove <crate>` (with `--package <pkg>` in workspaces). Never edit `[dependencies]` in `Cargo.toml` by hand.
- **Node dependencies:** `npm install <pkg>`, `pnpm add <pkg>`, `bun add <pkg>`. Never edit `package.json` `"dependencies"` by hand.
- **Python dependencies:** `uv add <pkg>`, `poetry add <pkg>`, `pip install` + lockfile regen. Never edit `pyproject.toml` / `requirements.txt` directly.
- **Go modules:** `go get <module>` / `go mod tidy`. Don't edit `go.mod` by hand.
- **Database migrations:** `sqlx migrate add <name>`, `alembic revision -m <name>`, `rails generate migration ...`, project-equivalent. Never create migration files manually.
- **Git config:** `git config <key> <value>`. Don't edit `.git/config` by hand.

Only read the underlying config file to inspect current state. If you don't know the right CLI command, ask or look it up — don't fall back to hand-editing.
