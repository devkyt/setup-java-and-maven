#!/bin/bash

function get_arch {
    ARCH=$(uname -m)

    case $ARCH in 
        "x86_64" | "amd64")
        ARCH="x64";;
        "arm64")
        ARCH="aarch64";;
    esac

    echo $ARCH

}

function get_os {
    OS=$(uname | tr '[:upper:]' '[:lower:]')

    case $OS in 
        "linux")
        OS="linux";;
        "darwin")
        OS="macos";;
    esac

    echo $OS
}

function build_java_url {
   local JAVA_FULL_VERSION=$1
   local OS=$2
   local ARCH=$3

   echo "https://github.com/graalvm/graalvm-ce-builds/releases/download/jdk-${JAVA_FULL_VERSION}/graalvm-community-jdk-${JAVA_FULL_VERSION}_${OS}-${ARCH}_bin.tar.gz"

}

function build_maven_url {
    local MAVEN_FULL_VERSION=$1
    local MAVEN_MAJOR_VERSION=$2

    echo "https://archive.apache.org/dist/maven/maven-${MAVEN_MAJOR_VERSION}/${MAVEN_FULL_VERSION}/binaries/apache-maven-${MAVEN_FULL_VERSION}-bin.tar.gz"

}

function download_and_unpack {
    local URL=$1
    local ARCHIVE="./env/${2}.tar.gz"
    local WHERE_TO_UNPACK="./env/${2}"

    curl -L $URL > $ARCHIVE
    tar -xf $ARCHIVE -C $WHERE_TO_UNPACK --strip-components=1
}
