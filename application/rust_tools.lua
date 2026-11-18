local helpers = require("../helpers")

task "install_rust_tools" {
    handler = function(target_system)
        helpers.execute_commands(target_system, {
            "cargo install --locked cargo-binstall",

            "cargo binstall -y zellij",
            "cargo binstall -y gitui",
            "cargo binstall -y bat",
            "cargo binstall -y ripgrep",
            "cargo binstall -y erdtree",
            "cargo binstall -y repgrep",
            "cargo binstall -y cargo-modules",
            "cargo binstall -y fd-find",
            "cargo binstall -y nu",
            "cargo binstall -y git-delta",
            "cargo binstall -y trunk",
            "cargo binstall -y sqlx-cli",
            "cargo binstall -y cargo-watch",
            "cargo binstall -y cargo-expand",

            "rustup component add rust-analyzer",
        })
    end,
}

return nil
