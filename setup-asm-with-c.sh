#!/bin/bash

# Setup nasm
sudo apt-get install -y -qq nasm gcc

# Path to the files
ASM_PATH="./src/"
C_PATH="./src/"

# Find the first .asm file in the directory
ASM_FILE=$(find "$ASM_PATH" -name "*.asm" | head -n 1)

if [ -z "$ASM_FILE" ]; then
    echo "No .asm file found in $ASM_PATH."
    exit 1
fi

# Find the first .c file in the directory (optional)
C_FILE=$(find "$C_PATH" -name "*.c" | head -n 1)

if [ -z "$C_FILE" ]; then
    echo "No .c file found in $C_PATH."
fi

# Extract the base name without the directory and extension
ASM_BASE_NAME=$(basename "$ASM_FILE" .asm)
C_BASE_NAME=$(basename "$C_FILE" .c)

# Standardized names for object and binary files
ASM_OBJ_FILE="${ASM_BASE_NAME}.o"
C_OBJ_FILE="${C_BASE_NAME}.o"

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
echo "Action: Compiling assembly file (${ASM_BASE_NAME}.asm) to object file (${ASM_OBJ}.o)"
nasm -f elf64 "$ASM_FILE" -o "${BIN_PATH}${ASM_OBJ_FILE}"
echo "Success: Assembly file compiled to object file."

# Compile .c to .o object file, if a C file exists
if [ ! -z "$C_FILE" ]; then
    echo "Action: Compiling C file (${C_BASE_NAME}.c) to object file (${C_OBJ_FILE})"
    gcc -c "$C_FILE" -o "${BIN_PATH}${C_OBJ_FILE}"
    echo "Success: C file compiled to object file."
fi

# Setting Base Name
if [ ! -z "$C_FILE" ]; then
    BIN_FILE="${C_BASE_NAME}.bin"
else
    echo "Action: Setting a base name"
    BIN_FILE="${ASM_BASE_NAME}.bin"
fi

# Link object files to create an executable
if [ ! -z "$C_FILE" ]; then
    echo "Action: Linking object files to create executable (${BIN_FILE})"
    gcc -o "${BIN_PATH}${BIN_FILE}" "${BIN_PATH}"*.o -no-pie
    echo "Success: Object files linked and executable created."
else
    echo "Action: Linking object files to create executable (${BIN_FILE})"
    ld -o "${BIN_PATH}${BIN_FILE}" "${BIN_PATH}${ASM_OBJ_FILE}"
    echo "Success: Object files linked and executable created."
fi

echo "Compilation and linking complete: ${BIN_FILE} is ready."
