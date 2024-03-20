#! /bin/env bash

cargo install --locked zellij
cargo install --locked gitui
cargo install --locked bat
cargo install --locked ripgrep
cargo install --locked erdtree
cargo install --locked repgrep
cargo install --locked cargo-modules
cargo install --locked lnkr
cargo install --locked fd-find
cargo install --locked nu
cargo install --locked git-delta
cargo install --locked trunk
cargo install --locked sqlx-cli
cargo install --locked cargo-watch

rustup component add rust-analyzer

# curl -sS https://starship.rs/install.sh | sh -s -s -- -y

