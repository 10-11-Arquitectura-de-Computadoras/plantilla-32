# User Ubuntu 22.04 as the base image
FROM mcr.microsoft.com/devcontainers/base:jammy

# Avoid prompts from apt
ARG DEBIAN_FRONTEND=noninteractive

# Update the package repository
RUN apt-get update

# Git
RUN apt-get install -y git

# ld (linker) 
RUN apt-get install -y binutils

# NASM
RUN apt-get install -y nasm

# GCC
RUN apt-get install -y gdb

# Open PORTS
EXPOSE 8080 5000 8081 443

# Set the shell as the entrypoint of the container
ENTRYPOINT ["/bin/bash"]
