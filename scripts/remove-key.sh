#!/bin/sh
security delete-keychain ios-build.keychain
rm -f ~/Library/MobileDevice/Provisioning\ Profiles/$PROFILE_NAME.mobileprovision


echo "my name appear here rahul yadav"

if [ ! -z "$BUNDLE_DISPLAY_NAME" ]; then
  echo "my name appear here rahul yadav"
fi