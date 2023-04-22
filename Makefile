list: # "list targets"
	@grep '^[^#[:space:]].*:' Makefile

arch-base: # "setup arch linux base"
	sudo pacman -S base-devel --noconfirm
	sudo pacman -S openssh --noconfirm
	sudo pacman -S git --noconfirm

rust: # "install rust using rustup"
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --default-toolchain stable -y

rust-tools-arch: # "install oxidized tools using pacman"
	sudo pacman -S helix --noconfirm
	sudo pacman -S nushell --noconfirm

rust-tools-fedora: # "install oxidized tools using dnf"
	sudo dnf copr enable varlad/helix
	sudo dnf install helix

rust-tools: # "install oxidized tools using the rust toolchain / curl"
	cargo install --locked zellij
	cargo install --locked gitui
	cargo install --locked bat
	cargo install --locked ripgrep
	cargo install --locked erdtree
	cargo install --locked repgrep
	cargo install --locked cargo-modules
	cargo install --locked dotlink
	rustup component add rust-analyzer
	
	curl -sS https://starship.rs/install.sh | sh -s -s -- -y

web-tools:
	cargo install fnm
	# echo 'eval "$(fnm env --use-on-cd)"' >> ~/.bashrc
