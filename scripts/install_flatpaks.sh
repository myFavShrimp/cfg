#!/bin/bash

FILENAME='resources/flatpaks'

FLATPAKS=$(cat $FILENAME | while read line; do echo -n "$line "; done)
flatpak install --noninteractive flathub $FLATPAKS
