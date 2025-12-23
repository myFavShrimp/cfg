local helpers = require("helpers")

tasks["install_rust"] = {
    handler = function(system)
        local commands = {
            "curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --default-toolchain stable -y",
        }

        helpers.execute_commands(system, unpack(commands))
    end,
}
