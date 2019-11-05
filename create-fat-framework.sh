#!/bin/bash

# Forked from https://gist.github.com/sundeepgupta/3ad9c6106e2cd9f51c68cf9f475191fa

CONFIGURATION="Release"
BUILD_DIR="build"
UNIVERSAL_OUTPUT_DIR="$BUILD_DIR/$CONFIGURATION-universal"

# make sure the output directory exists
mkdir -p "$UNIVERSAL_OUTPUT_DIR"

# Step 1. Build Device and Simulator versions
xcodebuild -scheme "HuhiRewards" ONLY_ACTIVE_ARCH=NO -configuration $CONFIGURATION CONFIGURATION_BUILD_DIR="$BUILD_DIR/$CONFIGURATION-iphoneos" clean build -sdk iphoneos
xcodebuild -scheme "HuhiRewards" ONLY_ACTIVE_ARCH=NO -configuration $CONFIGURATION CONFIGURATION_BUILD_DIR="$BUILD_DIR/$CONFIGURATION-iphonesimulator" clean build -sdk iphonesimulator

# Step 2. Copy the framework structure (from iphoneos build) to the universal folder
cp -R "$BUILD_DIR/$CONFIGURATION-iphoneos/HuhiRewards.framework" "$UNIVERSAL_OUTPUT_DIR/"
cp -R "$BUILD_DIR/$CONFIGURATION-iphoneos/HuhiRewards.framework.dSYM" "$UNIVERSAL_OUTPUT_DIR/"
cp -R "$BUILD_DIR/$CONFIGURATION-iphoneos/HuhiRewardsUI.framework" "$UNIVERSAL_OUTPUT_DIR/"
cp -R "$BUILD_DIR/$CONFIGURATION-iphoneos/HuhiRewardsUI.framework.dSYM" "$UNIVERSAL_OUTPUT_DIR/"

# Step 3. Copy Swift modules from iphonesimulator build (if it exists) to the copied framework directory
SIMULATOR_SWIFT_MODULES_DIR="$BUILD_DIR/$CONFIGURATION-iphonesimulator/HuhiRewards.framework/Modules/HuhiRewards.swiftmodule/."
if [ -d "$SIMULATOR_SWIFT_MODULES_DIR" ]; then
    cp -R "$SIMULATOR_SWIFT_MODULES_DIR" "$UNIVERSAL_OUTPUT_DIR/HuhiRewards.framework/Modules/HuhiRewards.swiftmodule"
fi
SIMULATOR_SWIFT_MODULES_DIR="$BUILD_DIR/$CONFIGURATION-iphonesimulator/HuhiRewardsUI.framework/Modules/HuhiRewardsUI.swiftmodule/."
if [ -d "$SIMULATOR_SWIFT_MODULES_DIR" ]; then
    cp -R "$SIMULATOR_SWIFT_MODULES_DIR" "$UNIVERSAL_OUTPUT_DIR/HuhiRewardsUI.framework/Modules/HuhiRewardsUI.swiftmodule"
fi

# Step 4. Create universal binary file using lipo and place the combined executable in the copied framework directory
lipo -create -output "$UNIVERSAL_OUTPUT_DIR/HuhiRewards.framework/HuhiRewards" "$BUILD_DIR/$CONFIGURATION-iphonesimulator/HuhiRewards.framework/HuhiRewards" "$BUILD_DIR/$CONFIGURATION-iphoneos/HuhiRewards.framework/HuhiRewards"
lipo -create -output "$UNIVERSAL_OUTPUT_DIR/HuhiRewardsUI.framework/HuhiRewardsUI" "$BUILD_DIR/$CONFIGURATION-iphonesimulator/HuhiRewardsUI.framework/HuhiRewardsUI" "$BUILD_DIR/$CONFIGURATION-iphoneos/HuhiRewardsUI.framework/HuhiRewardsUI"
