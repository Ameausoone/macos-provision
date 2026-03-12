#!/usr/bin/env zsh

# mise: To enable macOS integration for Java
JAVA_VERSION=$(mise current java)
JDK_DIR="/Library/Java/JavaVirtualMachines/${JAVA_VERSION}.jdk"

if [[ ! -d "$JDK_DIR" ]]; then
    sudo mkdir -p "$JDK_DIR"
    echo "Created JDK directory at $JDK_DIR for mise/MacOs Java integration."
fi

if [[ ! -L "$JDK_DIR/Contents" ]]; then
    sudo ln -sf "$(mise where java)/Contents" "$JDK_DIR/Contents"
    echo "Linked $(mise where java)/Contents to $JDK_DIR/Contents for mise/MacOs Java integration."
fi
