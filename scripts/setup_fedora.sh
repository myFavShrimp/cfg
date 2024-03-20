#! /bin/env bash

sudo dnf update -y
bash ./scripts/load_dconf.sh

# rpmfusion
sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo dnf config-manager --enable fedora-cisco-openh264

# nvidia
sudo dnf install akmod-nvidia # rhel/centos users can use kmod-nvidia instead
sudo dnf install xorg-x11-drv-nvidia-cuda #optional for cuda/nvdec/nvenc support

# project dependencies and necessary libraries
sudo dnf install perl-FindBin perl-IPC-Cmd perl-File-Compare perl-File-Copy podman-compose
sudo dnf swap ffmpeg-free ffmpeg --allowerasing -y

# helix
sudo dnf copr enable varlad/helix
sudo dnf install helix

bash scripts/rust.sh
bash ./scripts/rust_tools.sh
