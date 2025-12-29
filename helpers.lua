local helpers = {}

function helpers.execute_commands(system, ...)
    local commands = {...}

    for _, command in ipairs(commands) do
        log.debug("Running command '" .. command .."'")
        local result = system:run_command(command)

        if result.exit_code ~= 0 then
            error("Command failed: " .. command .. "\nError: " .. result.stderr)
        end
    end
end

function helpers.trim_whitespace(text)
    return text:gsub("^%s*(.-)%s*$", "%1")
end

return helpers
