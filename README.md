# Setup Java and Maven

Straightforward action to setup Java and Maven on linux or macos. It uses [GraalVM](https://github.com/graalvm) as a JDK distibution.<br>

**Note**: "straightforward" means that this action isn't damn complex or flexible. But still, it's good enough to prepare env for some projects. The decent workhorse. 

## Usage

Here we go:

```
steps:
- name: Install Java and Maven
  uses: s8ckerpunch/setup-java-and-maven@beta
  with:
    JAVA_VERSION: "11"
    MAVEN_VERSION: "3.5.4"
```

**Supported Java Versions**: 8, 11, 17, 19, 20, 21.</br>
**Supported Maven Versions**: still in test.
