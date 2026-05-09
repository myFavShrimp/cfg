---
name: arc — use idiomatic task patterns
description: Use important tasks + when guards for conditional execution; don't parse run_command output for control flow
type: feedback
---

When writing `arc.lua` automation, follow the idiomatic patterns:

- Use `important = true` tasks for detection/checks that return results.
- Use `when` guards on dependent tasks to read prior task results (e.g., `when = function() return tasks["detect_os"].result == "linux" end`).
- Avoid parsing `system:run_command` stdout for control flow. Either use shell substitution inline (e.g., `$(brew --prefix openssl@3)`) or model the check as a check task that returns a value.
- Use `arc.project_root_path` to locate paths relative to the `arc.lua` location.

**Example:**

```lua
tasks["check_postgres_running"] = {
    important = true,
    handler = function(system)
        return system:run_command("pg_isready").exit_code == 0
    end,
}

tasks["start_postgres"] = {
    requires = {"check_postgres_running"},
    when = function() return tasks["check_postgres_running"].result == false end,
    handler = function(system)
        system:run_command("systemctl start postgresql")
    end,
}
```
