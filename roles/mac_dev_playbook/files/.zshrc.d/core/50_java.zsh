#!/usr/bin/env zsh

# mise: To enable macOS integration for Java
JAVA_VERSION=$(mise current java)
JDK_DIR="/Library/Java/JavaVirtualMachines/${JAVA_VERSION}.jdk"

if [[ ! -d "$JDK_DIR" ]]; then
    sudo mkdir -p "$JDK_DIR"
fi

if [[ ! -L "$JDK_DIR/Contents" ]]; then
    sudo ln -sf "$(mise where java)/Contents" "$JDK_DIR/Contents"
fi
