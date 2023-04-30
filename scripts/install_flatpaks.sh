#!/bin/bash

FLATPAKS=$(cat resources/flatpaks | while read line; do echo -n "$line "; done)
flatpak install --noninteractive flathub $FLATPAKS
