local helpers = require("helpers")

local nvm_version = "v0.40.6"

-- Globally installed npm packages live inside the active node version, so these
-- have to be reinstalled after switching to a node version that lacks them.
local global_packages = {
    "typescript-language-server",
}

local function in_nvm_environment(command)
    return "bash -c 'export NVM_DIR=\"$HOME/.nvm\"; . \"$NVM_DIR/nvm.sh\"; " .. command .. "'"
end

tasks["check_nvm_installed"] = {
    when = function()
        return tasks["check_is_macos"].result == true
    end,
    handler = function(system)
        local result = system:run_command("test -s ~/.nvm/nvm.sh")

        if result.exit_code == 0 then
            log.info("nvm is already installed")

            return true
        else
            log.info("nvm is not installed")

            return false
        end
    end,
}

tasks["install_nvm"] = {
    requires = {"check_nvm_installed"},
    when = function()
        return tasks["check_is_macos"].result == true and tasks["check_nvm_installed"].result == false
    end,
    handler = function(system)
        -- PROFILE=/dev/null keeps the installer from appending its own snippet to
        -- the shell profiles, since nushell loads nvm through config/commands/nvm.nu.
        local install_command = "PROFILE=/dev/null bash -c 'curl -fsSL "
            .. "https://raw.githubusercontent.com/nvm-sh/nvm/" .. nvm_version .. "/install.sh | bash'"

        helpers.execute_commands(system, install_command)
    end,
}

tasks["install_node_lts"] = {
    requires = {"install_nvm"},
    when = function()
        return tasks["check_is_macos"].result == true
    end,
    handler = function(system)
        helpers.execute_commands(system, in_nvm_environment("nvm install --lts"))
    end,
}

tasks["install_global_npm_packages"] = {
    when = function()
        return tasks["check_is_macos"].result == true
    end,
    handler = function(system)
        for _, global_package in ipairs(global_packages) do
            helpers.execute_commands(system, in_nvm_environment("npm install -g " .. global_package))
        end
    end,
}
