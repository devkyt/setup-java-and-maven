#!/bin/bash

function is_java_version_valid {
    JAVA_VERSION=$1
    local JAVA_VERSIONS=("21", "20", "19", "17", "11", "8")

    if [[ ! ${JAVA_VERSIONS[@]} =~ $JAVA_VERSION ]]; then
        echo "Unavailable Java version. You shoud use one of these: ${JAVA_VERSIONS[@]}"
        exit 1
    fi
}

function get_arch {
    JAVA_VERSION=$1
    ARCH=$(uname -m)

    case $ARCH in 
        "x86_64" | "amd64")
            if [[ $JAVA_VERSION -ge 17 ]]; then
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
    JAVA_VERSION=$1
    OS=$(uname | tr '[:upper:]' '[:lower:]')

    case $OS in 
        "linux")
        OS="linux";;
        "darwin")
        if [[ $JAVA_VERSION -ge 17 ]]; then
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

   case $JAVA_VERSION in
        "21")
        JAVA_URL="https://github.com/graalvm/graalvm-ce-builds/releases/download/jdk-${JAVA_VERSION}/graalvm-community-jdk-${JAVA_VERSION}.0.0_${OS}-${ARCH}_bin.tar.gz";;
        "20")
        JAVA_URL="https://github.com/graalvm/graalvm-ce-builds/releases/download/jdk-${JAVA_VERSION}/graalvm-community-jdk-${JAVA_VERSION}.0.2_${OS}-${ARCH}_bin.tar.gz";;
        "19")
        JAVA_URL="https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-22.3.0/graalvm-ce-java19-${OS}-${ARCH}-22.3.0.tar.gz";;
        "17")
        JAVA_URL="https://github.com/graalvm/graalvm-ce-builds/releases/download/jdk-${JAVA_VERSION}/graalvm-community-jdk-${JAVA_VERSION}.0.8_${OS}-${ARCH}_bin.tar.gz";;
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

    curl -L $URL > $ARCHIVE
    tar -xf $ARCHIVE -C $WHERE_TO_UNPACK --strip-components=1
}

function clean_it_up {
    rm ./env/*.gz
}
