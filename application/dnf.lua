local helpers = require("../helpers")

local packages = {
    "perl-FindBin",
    "perl-IPC-Cmd",
    "perl-File-Compare",
    "perl-File-Copy",
    "podman-compose",
    "helix",
    "alacritty",
    "nodejs",
    "nodejs-bash-language-server",
}

task "install_dnf_packages" {
    when = function()
        return task["check_is_fedora"].result == true
    end,
    handler = function(target_system)
        local commands = {
            "sudo dnf group install development-tools -y",
        }

        for _, package in packages do
            table.insert(commands, "sudo dnf install -y " .. package)
        end

        helpers.execute_commands(target_system, commands)
    end,
}

return nil
