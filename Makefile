list: # list commands
	@grep '^[^#[:space:]].*:' Makefile

rust: # install rust using rustup
	bash scripts/rust.sh

rust-tools: # install oxidized tools using the rust toolchain / curl
	bash scripts/rust_tools.sh

flatpaks: # install flatpaks listed in resources/flatpaks
	bash scripts/install_flatpaks.sh

extensions: # install extensions listed in resources/extensions
	bash scripts/install_extensions.sh

load-dconf: # load dconf settings
	bash scripts/load_dconf.sh

# dump-all-dconf: # dump all dconf settings
# 	dconf dump / > all-dconf.dconf

copy-fonts: # install fonts
	mkdir -p /usr/share/fonts/hack
	cp -r fonts/Hack /usr/share/fonts/hack
	rm -rf /usr/share/fonts/hack/Windows
	# nu scripts/install_fonts.nu

setup-fedora: # initial setup on fedora workstation
	bash scripts/setup_fedora.sh

