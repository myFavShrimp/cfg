local helpers = require("helpers")

tasks["install_rust_tools"] = {
    handler = function(system)
        local commands = {
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

            "rustup component add rust-analyzer",
        }

        helpers.execute_commands(system, unpack(commands))
    end,
    dependencies = { "install_rust" },
}
