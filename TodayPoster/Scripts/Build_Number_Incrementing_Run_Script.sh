#!/bin/bash

# Update the Info.plist build number with number of git commits
buildNumber=$(git rev-list HEAD --count) \
    || exit 1
echo "note: Updating build number to ${buildNumber}..."

# Update the Info.plist build number with number of git commits
/usr/libexec/PlistBuddy \
    -c "Set CFBundleVersion ${buildNumber}" \
    "${TARGET_BUILD_DIR}/${INFOPLIST_PATH}" \
    || exit 1
