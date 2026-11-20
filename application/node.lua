local helpers = require("../helpers")

local nvm_version = "v0.40.6"

-- Globally installed npm packages live inside the active node version, so these
-- have to be reinstalled after switching to a node version that lacks them.
local global_packages = {
    "typescript-language-server",
}

local function in_nvm_environment(command: string): string
    return "bash -c 'export NVM_DIR=\"$HOME/.nvm\"; . \"$NVM_DIR/nvm.sh\"; " .. command .. "'"
end

task "check_nvm_installed" {
    when = function()
        return task["check_is_macos"].result == true
    end,
    handler = function(target_system)
        local is_nvm_installed = target_system:run_command("test -s ~/.nvm/nvm.sh").exit_code == 0

        if is_nvm_installed then
            log.info("nvm is already installed")
        else
            log.info("nvm is not installed")
        end

        return is_nvm_installed
    end,
}

task "install_nvm" {
    requires = {"check_nvm_installed"},
    when = function()
        return task["check_is_macos"].result == true and task["check_nvm_installed"].result == false
    end,
    handler = function(target_system)
        -- PROFILE=/dev/null keeps the installer from appending its own snippet to
        -- the shell profiles, since nushell loads nvm through config/commands/nvm.nu.
        local install_command = "PROFILE=/dev/null bash -c 'curl -fsSL "
            .. "https://raw.githubusercontent.com/nvm-sh/nvm/" .. nvm_version .. "/install.sh | bash'"

        helpers.execute_commands(target_system, { install_command })
    end,
}

task "install_node_lts" {
    requires = {"install_nvm"},
    when = function()
        return task["check_is_macos"].result == true
    end,
    handler = function(target_system)
        helpers.execute_commands(target_system, { in_nvm_environment("nvm install --lts") })
    end,
}

task "install_global_npm_packages" {
    when = function()
        return task["check_is_macos"].result == true
    end,
    handler = function(target_system)
        local commands = {}

        for _, global_package in global_packages do
            table.insert(commands, in_nvm_environment("npm install -g " .. global_package))
        end

        helpers.execute_commands(target_system, commands)
    end,
}

return nil
