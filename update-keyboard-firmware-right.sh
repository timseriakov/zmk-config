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
TARGET_FILES=("corne_right-nice_nano_v2-zmk.uf2" "gbEnki_right-nice_nano_v2-zmk.uf2")
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

found_file=""

for target_file in "${TARGET_FILES[@]}"; do
    result_file="$(dirname "$ZIP_PATH")/$target_file"
    if [ ! -f "$result_file" ]; then
        result_file="$(dirname "$ZIP_PATH")/firmware/$target_file"
    fi
    if [ -f "$result_file" ]; then
        found_file="$result_file"
        break
    fi
done

if [ -f "$found_file" ]; then
    cp "$found_file" "$DESTINATION/"
    echo "Firmware $(basename "$found_file") updated."
    rm -f "$ZIP_PATH" "$found_file"
else
    echo "No target firmware files found."
fi
