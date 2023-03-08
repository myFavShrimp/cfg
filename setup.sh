sudo dnf copr enable atim/alacritty
sudo dnf install alacritty

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --default-toolchain stable -y

sudo dnf copr enable varlad/helix
sudo dnf install helix

curl -sS https://starship.rs/install.sh | sh
echo 'eval "$(starship init bash)"' >> ~/.bashrc

cargo install --locked zellij
sudo dnf install gitui

rustup component add rust-analyzer

cargo install fnm
echo 'eval "$(fnm env --use-on-cd)"' >> ~/.bashrc
