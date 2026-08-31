In `arc.lua`, when an operation naturally fans out across a collection (multiple Docker images, multiple services, multiple files to render), prefer **one task that iterates internally** over generating N tasks via a `for ... do tasks[...] = {...} end` block.

**Yes:**

```lua
tasks["build_images"] = {
    handler = function()
        for _, image in ipairs(config.images) do
            host:run_command("docker build -t " .. image.name .. " ...")
        end
    end,
    tags = {"build"},
}
```

**No:**

```lua
for _, image in ipairs(config.images) do
    tasks["build_" .. image.name] = {
        handler = function() ... end,
        tags = {"build"},
    }
end
```

The single-task form keeps the task list short, makes run order obvious, and reduces dependency-edge clutter. Only split into per-item tasks if the items legitimately need independent run/skip/`requires` logic.
