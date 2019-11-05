# huhi-rewards-ios

A UI framework for consuming Huhi Rewards on [huhi-ios](https://github.com/huhi/huhi-ios). The core logic around HuhiRewards resides in huhi-core

The latest HuhiRewards.framework was built on:

```
huhi-browser/459bf88860c9809d7ccabd43157cf7c0984d3fc7
huhi-core/e28df2f318db7fba76fa281f58b9a84311f8ee53
```

Building the code
-----------------

1. Install the latest [Xcode developer tools](https://developer.apple.com/xcode/downloads/) from Apple. (Xcode 10 and up required)
1. Install Carthage:
    ```shell
    brew update
    brew install carthage
    ```
1. Install SwiftLint:
    ```shell
    brew install swiftlint
    ```
1. Clone the repository:
    ```shell
    git clone https://github.com/huhi/huhi-rewards-ios.git
    ```
1. Pull in the project dependencies:
    ```shell
    cd huhi-rewards-ios
    carthage bootstrap --platform ios --cache-builds --no-use-binaries
    ```
1. Open `HuhiRewards.xcodeproj` in Xcode.
1. Build the `HuhiRewardsExample` scheme in Xcode
