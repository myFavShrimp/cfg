#!/bin/bash

FILENAME='resources/gnome-extensions'

while read EXTENSION; do
    EXTENSION_ID=$(curl -s $EXTENSION | grep -oP 'data-uuid="\K[^"]+')
    echo "https://extensions.gnome.org/extension-query/?search=${EXTENSION_ID}"
    VERSION_TAG=$(curl -Lfs "https://extensions.gnome.org/extension-query/?search=${EXTENSION_ID}" | jq '.extensions[0] | .shell_version_map | map(.pk) | max')

    echo "https://extensions.gnome.org/download-extension/${EXTENSION_ID}.shell-extension.zip?version_tag=${VERSION_TAG}"
    wget -O ${EXTENSION_ID}.zip "https://extensions.gnome.org/download-extension/${EXTENSION_ID}.shell-extension.zip?version_tag=${VERSION_TAG}"
    unzip ${EXTENSION_ID}.zip -d /usr/share/gnome-shell/extensions/${EXTENSION_ID}

    rm ${EXTENSION_ID}.zip
done < "$FILENAME"
