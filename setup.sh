#!/bin/bash
source "./helpers.sh"

JAVA_FULL_VERSION=$1
MAVEN_FULL_VERSION=$2
MAVEN_MAJOR_VERSION=${MAVEN_FULL_VERSION:0:1}

ARCH=$(get_arch)
OS=$(get_os)

# CREATE DIRS FOR JAVA & MAVEN
mkdir -p env/jdk && mkdir -p env/maven

# INSTALL JAVA
JAVA_URL=$(build_java_url $JAVA_FULL_VERSION $OS $ARCH)
download_and_unpack $JAVA_URL "jdk" 

# INSTALL MAVEN
MAVEN_URL=$(build_maven_url $MAVEN_FULL_VERSION $MAVEN_MAJOR_VERSION)
download_and_unpack $MAVEN_URL "maven"


curl -L \
  -H "Accept: application/vnd.github+json" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  https://api.github.com/repos/graalvm/graalvm-ce-builds/releases



