local helpers = require("../helpers")

local packages = {
    "helix",
    "openssl",
    "php@8.4",
    "mysql-client",
    "glab",
}

task "check_brew_installed" {
    when = function()
        return task["check_is_macos"].result == true
    end,
    handler = function(target_system)
        local is_brew_installed = target_system:run_command("which brew").exit_code == 0

        if is_brew_installed then
            log.info("brew is already installed")
        else
            log.info("brew is not installed")
        end

        return is_brew_installed
    end,
}

task "install_brew" {
    requires = { "check_brew_installed" },
    when = function()
        return task["check_is_macos"].result == true and task["check_brew_installed"].result == false
    end,
    handler = function(target_system)
        helpers.execute_commands(target_system, {
            "NONINTERACTIVE=1 /bin/bash -c \"$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\"",
        })
    end,
}

task "install_brew_packages" {
    when = function()
        return task["check_is_macos"].result == true
    end,
    handler = function(target_system)
        local commands = {}

        for _, package in packages do
            table.insert(commands, "brew install " .. package)
        end

        helpers.execute_commands(target_system, commands)
    end,
}

return nil
