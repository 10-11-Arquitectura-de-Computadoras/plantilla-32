#!/bin/bash

# Setup nasm
sudo apt-get install -y -qq nasm

# Path to the files
ASM_PATH="./src/"

# Find the first .asm file in the directory
ASM_FILE=$(find "$ASM_PATH" -name "*.asm" | head -n 1)

if [ -z "$ASM_FILE" ]; then
    echo "No .asm file found in $ASM_PATH."
    exit 1
fi

# Extract the base name without the directory and extension
BASE_NAME=$(basename "$ASM_FILE" .asm)

# Standardized names for object and binary files
CODE_FILE="${BASE_NAME}.asm"
OBJ_FILE="${BASE_NAME}.o"
BIN_FILE="${BASE_NAME}.bin"

# Create binary directory
BIN_PATH="./bin/"

# Check if the folder does not exist
if [ ! -d "$BIN_PATH" ]; then
    # Folder does not exist, so create it
    mkdir -p "$BIN_PATH"
    echo "Folder '$BIN_PATH' created."
else
    echo "Folder '$BIN_PATH' already exists."
fi

# Compile .asm to .o object file
echo "Action: Compiling assembly file (${CODE_FILE}.asm) to object file (${OBJ_FILE}.o)"
nasm -f elf32 "./src/${CODE_FILE}" -o "./bin/${OBJ_FILE}"
echo "Success: Assembly file compiled to object file."

# Link object file to create a binary
echo "Action: Linking object file (${OBJ_FILE}.o) to create binary (${BIN_FILE})"
ld -m elf_i386 -o "./bin/${BIN_FILE}" "./bin/${OBJ_FILE}"
echo "Success: Object file linked and binary created."

echo "Compilation and linking complete: ${BIN_FILE} is ready."
