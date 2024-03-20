#! /bin/env bash

dconf load / < gnome/01-base-settings
dconf load / < gnome/02-extension-settings
sudo dconf update

