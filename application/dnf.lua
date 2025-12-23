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
    handler = function(system)
        local is_fedora = tasks["check_is_fedora"].result

        if not is_fedora then
            return
        end

        local commands = {
            "sudo dnf group install development-tools -y",
        }

        for _, package in ipairs(packages) do
            local install_command = "sudo dnf install -y " .. package

            table.insert(commands, install_command)
        end

        helpers.execute_commands(system, unpack(commands))
    end,
    dependencies = { "check_is_fedora" },
}
