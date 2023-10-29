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

Run all tests for: macOS, iOS, tvOS & watchOS

### test

```sh
[bundle exec] fastlane test
```

Run tests for a specific platform

Optional: platform - Runs the unit tests for the given platform. Options are: macOS, iOS, watchOS or tvOS. The options are not case sensitive. Defaults to 'ios'

----

This README.md is auto-generated and will be re-generated every time [_fastlane_](https://fastlane.tools) is run.

More information about _fastlane_ can be found on [fastlane.tools](https://fastlane.tools).

The documentation of _fastlane_ can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
