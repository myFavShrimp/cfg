local helpers = {}

function helpers.execute_commands(target_system: System, commands: { string })
    for _, command in commands do
        local result = target_system:run_command(command)

        if result.exit_code ~= 0 then
            error("Command failed: " .. command .. "\nError: " .. result.stderr)
        end
    end
end

return helpers
