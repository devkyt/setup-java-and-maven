#!/bin/bash
source "./bin/helpers.sh"
source "./bin/validators.sh"

JAVA_VERSION=$1
MAVEN_FULL_VERSION=$2
MAVEN_MAJOR_VERSION=${MAVEN_FULL_VERSION:0:1}

is_java_version_valid $JAVA_VERSION || exit 1

ARCH=$(get_arch $JAVA_VERSION)
OS=$(get_os $JAVA_VERSION)

is_arch_valid $JAVA_VERSION $ARCH $OS || exit 1

JAVA_URL=$(build_java_url $JAVA_VERSION $OS $ARCH)
download_and_unpack $JAVA_URL "jdk" 

MAVEN_URL=$(build_maven_url $MAVEN_FULL_VERSION $MAVEN_MAJOR_VERSION)
download_and_unpack $MAVEN_URL "maven"

clean_it_up



