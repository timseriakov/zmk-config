#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Update keyboard firmware [right]
# @raycast.mode compact

# Optional parameters:
# @raycast.icon ⌨️

BASE_DIR="/Users/tim/Downloads/"
ZIP_NAME="firmware.zip"
ZIP_PATH="${BASE_DIR}${ZIP_NAME}"
DELAY_SECONDS=2
TARGET_FILE="corne_right-nice_nano_v2-zmk.uf2"
DESTINATION="/Volumes/NICENANO"

sleep $DELAY_SECONDS

if [ ! -f "$ZIP_PATH" ]; then
    echo "$ZIP_NAME not found"
    exit 1
fi

if [ ! -d "$DESTINATION" ]; then
    echo "Keyboard is not ready."
    exit 1
fi

unzip -o "$ZIP_PATH" -d "$(dirname "$ZIP_PATH")"

result_file="$(dirname "$ZIP_PATH")/$TARGET_FILE"

if [ ! -f "$result_file" ]; then
    result_file="$(dirname "$ZIP_PATH")/firmware/$TARGET_FILE"
fi

if [ -f "$result_file" ]; then
    cp "$result_file" "$DESTINATION/"

    echo "Firmware updated."

    rm -f "$ZIP_PATH" "$result_file"
else
    echo "$TARGET_FILE not found."
fi



