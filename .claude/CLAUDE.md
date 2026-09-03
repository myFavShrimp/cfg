# Personal preferences

Before answering, no matter how simple the answer, or whatever excuse you come up with, use the `no-ai-slop` skill to make sure your output is in the desired format. Even for one-word answers.

Do NOT fear context or tokens or quota. This is NOT your problem. You can handle 1M context easily. I want to see at least one skill call for a new chat. If you find more skills that are relevant, call these as well.

## Working approach

### Read skills eagerly

Read skills rightaway whenever they looks even remotely relevant to the task or project at hand. Do not wait until you are sure they apply, and do not decide from the skill name alone that you already know what it says. The skill description is not a substitute for reading it.

A skill you skipped is the likeliest reason for work that ignores an existing convention, tooling, or setup.

Go even further: read it before doing anything in that project - including quick lookups and one-line answers.

### Verify before claiming

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

### Use tooling, not manual edits

When a tool provides a CLI to mutate its config, use the CLI. Do not hand-edit the underlying file.

**Examples (the preference is NOT exclusive to those):**

- **Rust dependencies:** `cargo add <crate>` / `cargo remove <crate>` (with `--package <pkg>` in workspaces). Never edit `[dependencies]` in `Cargo.toml` by hand.
- **Node dependencies:** `npm install <pkg>`, `pnpm add <pkg>`, `bun add <pkg>`. Never edit `package.json` `"dependencies"` by hand.
- **Python dependencies:** `uv add <pkg>`, `poetry add <pkg>`, `pip install` + lockfile regen. Never edit `pyproject.toml` / `requirements.txt` directly.
- **Go modules:** `go get <module>` / `go mod tidy`. Don't edit `go.mod` by hand.
- **Database migrations:** `sqlx migrate add <name>`, `alembic revision -m <name>`, `rails generate migration ...`, project-equivalent. Never create migration files manually.
- **Git config:** `git config <key> <value>`. Don't edit `.git/config` by hand.

Only read the underlying config file to inspect current state. If you don't know the right CLI command, ask or look it up — don't fall back to hand-editing.

## Code style (general)

### No abbreviations

Use full, descriptive identifier names. Do not abbreviate.

**Examples:**

- `buf` → `buffer`
- `r`, `res` → `result`
- `p` → `path`
- `cmd` → `command`
- `ctx` → `context`
- `tmpl` → `template_content`
- `arg` → `argument`
- `ws_result` → `workspaces_result`
- `exec_prefix` → `execute_prefix`
- `item` → `storage_item`, `inventory_item`, etc. (whatever it actually is)
- `i`, `j` → `index`, `row_index`, `column_index` (or whatever the counter actually counts)

The only allowed short name is `_` for genuinely-unused bindings.

### Minimal comments

Do not add comments that describe what the code does. Variable names, function names, and the code itself already convey that.

**When a comment is appropriate:** a hidden constraint, a non-obvious workaround, or a subtle invariant that a future reader would otherwise miss. Keep it short.

**Specifically: never document the absence of a feature.** Don't write "no JSON output for this command" or "this CLI doesn't support X" — readers wouldn't assume the missing thing exists, so the comment adds zero signal.

Keep in mind that the codebase IS NOT a tutorial. The following is a bad comment, because it explains why an alternative route a beginner would chose (having a second value) or that was taken before was done in a different way now. Comments of this kind have no value.

```php
// The "back" destination comes from the payload: The session manages the history so
// that it survives a page reload. Without a destination, there is no handler—so
// "no back possible" should not be included as a second value alongside it.
const onBack = useMemo(
    () => previousStepId === null ? null : () => setCurrentStepId(previousStepId),
    [previousStepId],
);
```

### Blank line before return

Always leave a blank line before the returned expression in a function body.

Applies to both explicit `return` statements and implicit tail expressions (Rust, Lua, Ruby, etc.).

### Prefer the source of truth

Never use heuristics to infer information that can be queried directly from the authoritative source.

**Examples:**

- Determining whether a path is a file or a directory: query the filesystem (`std::fs::metadata`, `tokio::fs::metadata`, `os.stat`, etc.). Don't check whether the path has an extension.
- Determining a file's content type: read the magic bytes or query the OS. Don't trust the extension.
- Determining whether a binary is installed: `which` / `exec.LookPath`. Don't check predictable install paths.
- Determining whether a CLI flag exists: read the command's source/help. Don't extrapolate from sibling commands.

**How to apply:** when tempted to infer X from a name, path, or sibling, stop and ask whether X is directly queryable. Almost always it is. Use the query.

### Prefer readability over performance

Prefer readable code over simpler or more performant one.

Examples:

Simple but hardly readable

```php
public function previousPageId(): ?int
{
    return array_slice($this->history(), -2, 1)[0] ?? null;
}
```

Longer, but easier to understand and follow

```php
public function previousPageId(): ?int
{
    $history = $this->history();
    $previousPageIndex = count($history) - 2;

    return $history[$previousPageIndex] ?? null;
}
```

## CSS / SCSS

### No `!important`

Do not use `!important` in CSS or SCSS.

Achieve the needed specificity through proper selectors, restructured cascade, or scoped stylesheets — never via `!important`.

### SCSS nesting mirrors the HTML tags

When writing SCSS, nest selectors to mirror the structure of the corresponding HTML/template. Flat SCSS with all classes as siblings does not reflect the actual component tree and is harder to read.

**Example:**

Template:

```html
<div class="ResultItem">
  <div class="ResultIcon"></div>
  <div class="ResultLabel">
    <span class="ResultLabelText"></span>
  </div>
</div>
```

SCSS:

```scss
.ResultItem {
  .ResultIcon { ... }

  .ResultLabel {
    .ResultLabelText { ... }
  }
}
```

Not:

```scss
.ResultItem { ... }
.ResultIcon { ... }
.ResultLabel { ... }
.ResultLabelText { ... }
```

Always look at the corresponding template before writing or editing SCSS, and nest to match.

## UI / UX

### No success toasts

Do not show toasts on successful actions. When an action succeeds, just update the UI to reflect the new state.

Toasts are reserved for errors, and only when no inline display is viable.

## System specifics

@~/.claude/os.md

## Notes

@~/.claude/notes/global-memories.md
