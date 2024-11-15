fastlane documentation
----

# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```sh
xcode-select --install
```

For _fastlane_ installation instructions, see [Installing _fastlane_](https://docs.fastlane.tools/#installing-fastlane)

# Available Actions

### test_all

```sh
[bundle exec] fastlane test_all
```

Run all tests for: macOS, iOS, tvOS, watchOS & visionOS

### test

```sh
[bundle exec] fastlane test
```

Run tests for a specific platform. Use --env to select an environment. (ios, macos, tvos, watchos or visionos)

### code_coverage_all

```sh
[bundle exec] fastlane code_coverage_all
```

Generate code coverage reports for: macOS, iOS, tvOS & watchOS

### code_coverage

```sh
[bundle exec] fastlane code_coverage
```

Generate code coverage report for a specific platform. Use --env to select the environment. (ios, macos, tvos, watchos or visionos)

----

This README.md is auto-generated and will be re-generated every time [_fastlane_](https://fastlane.tools) is run.

More information about _fastlane_ can be found on [fastlane.tools](https://fastlane.tools).

The documentation of _fastlane_ can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
