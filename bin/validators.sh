#!/bin/bash

BoldRed='\033[1;31m'

function is_java_version_valid {
    local JAVA_VERSION=$1
    local JAVA_VERSIONS=("21", "20", "19", "17", "11", "8")

    if [[ ! ${JAVA_VERSIONS[@]} =~ $JAVA_VERSION ]]; then
        echo -e "${BoldRed}Error: unavailable Java version. You shoud use one of these: ${JAVA_VERSIONS[@]}" >&2
        exit 1
    fi
}

function is_arch_valid {
    local JAVA_VERSION=$1
    local ARCH=$2
    local OS=$3
    local MACOS=("macos", "darwin")

    if [[ $JAVA_VERSION -lt 17 && $ARCH == "aarch64" && ${MACOS[@]} =~ $OS ]]; then
        echo -e "${BoldRed}Error: macos amd64 is not supported on this distribution for Java versions < 17" >&2
        exit 1
    fi
}