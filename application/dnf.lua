local helpers = require("helpers")

local packages = {
    "perl-FindBin",
    "perl-IPC-Cmd",
    "perl-File-Compare",
    "perl-File-Copy",
    "podman-compose",
    "helix",
    "alacritty",
}

tasks["install_dnf_packages"] = {
    when = function()
        return tasks["check_is_fedora"].result == true
    end,
    handler = function(system)
        local commands = {
            "sudo dnf group install development-tools -y",
        }

        for _, package in ipairs(packages) do
            local install_command = "sudo dnf install -y " .. package

            table.insert(commands, install_command)
        end

        helpers.execute_commands(system, unpack(commands))
    end,
}
