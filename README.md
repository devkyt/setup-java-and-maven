# Setup Java and Maven

Straightforward action to setup Java and Maven on Linux or MacOS. It uses [GraalVM](https://github.com/graalvm) as a JDK distibution.<br>

**Note**: "straightforward" means that this action isn't damn complex or flexible. But still, it's good enough to prepare env for some projects. The decent workhorse.

## Usage

Here we go:

```yaml
steps:
  - name: Install Java and Maven
    uses: s8ckerpunch/setup-java-and-maven@v0.1
    with:
      JAVA_VERSION: "11"
      MAVEN_VERSION: "3.5.4"
```

Java 17 and Maven 3.9.4 will be installed be default if you don't specify any values.

**Supported Java Versions**: 8, 11, 17, 19, 20, 21.</br>
**Supported Maven Versions**: still in test.
