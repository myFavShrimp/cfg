In `arc.lua` task definitions, only use `requires` when the dependency task **must run every single time** the requiring task runs. `requires` triggers the dependency on every invocation, not just when state is missing.

**Do not** use `requires` to express "this task depends on state that another task creates." System state changes (a user being created, a package being installed, a directory existing) persist across runs. Re-running the setup task on every invocation of a downstream task is wasteful and often destructive.

**When `requires` is correct:** the dependency produces an in-memory `result` the requiring task reads (e.g., a version detection task whose return value the next task interpolates into a URL).

**When `requires` is wrong:** the requiring task only needs the side effect of an earlier task (file written, package installed, user created). Let the user run those setup tasks themselves; do not chain them.
