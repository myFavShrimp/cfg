local helpers = require("../helpers")

task "install_rust" {
    handler = function(target_system)
        helpers.execute_commands(target_system, {
            "curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --default-toolchain stable -y",
        })
    end,
}

return nil
