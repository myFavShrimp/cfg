local helpers = require("helpers")

local packages = {
    "helix",
    "openssl",
}

tasks["check_brew_installed"] = {
    important = true,
    when = function()
        return tasks["check_is_macos"].result == true
    end,
    handler = function(system)
        local result = system:run_command("which brew")

        if result.exit_code == 0 then
            log.info("brew is already installed")

            return true
        else
            log.info("brew is not installed")

            return false
        end
    end,
}

tasks["install_brew"] = {
    when = function()
        return tasks["check_is_macos"].result == true and tasks["check_brew_installed"].result == false
    end,
    handler = function(system)
        helpers.execute_commands(system, "NONINTERACTIVE=1 /bin/bash -c \"$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\"")
    end,
}

tasks["install_brew_packages"] = {
    when = function()
        return tasks["check_is_macos"].result == true
    end,
    handler = function(system)
        local commands = {}

        for _, package in ipairs(packages) do
            table.insert(commands, "brew install " .. package)
        end

        helpers.execute_commands(system, unpack(commands))
    end,
}
