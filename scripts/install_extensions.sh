#!/bin/bash

EXTENSIONS=(cat resources/extensions | while read line; do echo -n "$line "; done)

for EXTENSION in "${EXTENSIONS[@]}"
do
    EXTENSION_ID=$(curl -s $i | grep -oP 'data-uuid="\K[^"]+')
    VERSION_TAG=$(curl -Lfs "https://extensions.gnome.org/extension-query/?search=$EXTENSION_ID" | jq '.extensions[0] | .shell_version_map | map(.pk) | max')

    wget -O ${EXTENSION_ID}.zip "https://extensions.gnome.org/download-extension/${EXTENSION_ID}.shell-extension.zip?version_tag=$VERSION_TAG"
    unzip ${EXTENSION_ID}.zip -d /usr/share/gnome-shell/extensions/${EXTENSION_ID}

    rm ${EXTENSION_ID}.zip
done
