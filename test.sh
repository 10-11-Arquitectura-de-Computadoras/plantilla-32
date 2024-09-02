#!/bin/bash

# Path to the files
BIN_PATH="./bin/"

# Find the first .asm file in the directory
BIN_FILE=$(find "$BIN_PATH" -name "*.bin" | head -n 1)

if [ -z "$BIN_FILE" ]; then
    echo "No .bin file found in $BIN_PATH."
    exit 1
fi

# Set execute permission for the binary
chmod +x "${BIN_FILE}"

# Execute the binary
"./$BIN_FILE"
