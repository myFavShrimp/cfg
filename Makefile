list: # list commands
	@grep '^[^#[:space:]].*:' Makefile

rust: # install rust using rustup
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --default-toolchain stable -y

rust-tools: # install oxidized tools using the rust toolchain / curl
	cargo install --locked zellij
	cargo install --locked gitui
	cargo install --locked bat
	cargo install --locked ripgrep
	cargo install --locked erdtree
	cargo install --locked repgrep
	cargo install --locked cargo-modules
	cargo install --locked dotlink
	cargo install --locked fd-find
	cargo install --locked nu
	cargo install --locked just
	cargo install --locked git-delta
	rustup component add rust-analyzer
	
	curl -sS https://starship.rs/install.sh | sh -s -s -- -y

flatpaks: # install flatpaks listed in resources/flatpaks
	bash scripts/install_flatpaks.sh

extensions: # install extensions listed in resources/extensions
	bash scripts/install_extensions.sh

# load-dconf: # load dconf settings
# 	dconf load / < all-dconf.dconf

# dump-all-dconf: # dump all dconf settings
# 	dconf dump / > all-dconf.dconf

copy-fonts: # install fonts
	mkdir -p /usr/share/fonts/hack
	cp -r fonts/Hack /usr/share/fonts/hack
	rm -rf /usr/share/fonts/hack/Windows
	# nu scripts/install_fonts.nu
