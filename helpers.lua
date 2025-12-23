local helpers = {}

function helpers.execute_commands(system, ...)
    -- Store commands passed as arguments in a table
    local commands = {...}
    
    for _, command in ipairs(commands) do
        log.info("Running command '" .. command .."'")
        local result = system:run_command(command)
        
        if result.exit_code ~= 0 then
            error("Command failed: " .. command .. "\nError: " .. result.stderr)
        end
    end
end

return helpers
