#!/bin/bash

function get_arch {
    local JAVA_VERSION=$1
    local ARCH=$(uname -m)

    case $ARCH in 
        "x86_64" | "amd64")
            if [[ $JAVA_VERSION -ge 17 && $JAVA_VERSION -ne 19 ]]; then
                ARCH="x64"
            else
                ARCH="amd64"
            fi ;;
        "arm64")
        ARCH="aarch64";;
    esac

    echo $ARCH

}

function get_os {
    local JAVA_VERSION=$1
    local OS=$(uname | tr '[:upper:]' '[:lower:]')

    case $OS in 
        "linux")
        OS="linux";;
        "darwin")
        if [[ $JAVA_VERSION -ge 17 && $JAVA_VERSION -ne 19 ]]; then
            OS="macos"
        else
            OS="darwin"
        fi 
    esac

    echo $OS
}

function build_java_url {
   local JAVA_VERSION=$1
   local OS=$2
   local ARCH=$3
   local JAVA_URL=""

   case $JAVA_VERSION in
        "21")
        JAVA_VERSION="${JAVA_VERSION}.0.0"
        JAVA_URL="https://github.com/graalvm/graalvm-ce-builds/releases/download/jdk-${JAVA_VERSION}/graalvm-community-jdk-${JAVA_VERSION}_${OS}-${ARCH}_bin.tar.gz";;
        "20")
        JAVA_VERSION="${JAVA_VERSION}.0.2"
        JAVA_URL="https://github.com/graalvm/graalvm-ce-builds/releases/download/jdk-${JAVA_VERSION}/graalvm-community-jdk-${JAVA_VERSION}_${OS}-${ARCH}_bin.tar.gz";;
        "19")
        JAVA_URL="https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-22.3.0/graalvm-ce-java19-${OS}-${ARCH}-22.3.0.tar.gz";;
        "17")
        JAVA_VERSION="${JAVA_VERSION}.0.8"
        JAVA_URL="https://github.com/graalvm/graalvm-ce-builds/releases/download/jdk-${JAVA_VERSION}/graalvm-community-jdk-${JAVA_VERSION}_${OS}-${ARCH}_bin.tar.gz";;
        "11")
        JAVA_URL="https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-22.3.1/graalvm-ce-java11-${OS}-${ARCH}-22.3.1.tar.gz";;
        "8")
        JAVA_URL="https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-21.2.0/graalvm-ce-java8-${OS}-${ARCH}-21.2.0.tar.gz";; 
    esac

    echo $JAVA_URL 
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

    mkdir -p $WHERE_TO_UNPACK
    curl -L $URL > $ARCHIVE
    tar -xf $ARCHIVE -C $WHERE_TO_UNPACK --strip-components=1
}

function clean_it_up {
    rm ./env/*.gz
}
