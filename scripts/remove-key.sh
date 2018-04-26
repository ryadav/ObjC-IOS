#!/bin/sh
security delete-keychain ios-build.keychain
rm -f ~/Library/MobileDevice/Provisioning\ Profiles/$PROFILE_NAME.mobileprovision


myVal= cat ./scripts/customConfiguration.json | jq '.isCreateBuild'

if [ "$myVal" = "true" ]; then
  echo "x has the value 'valid'"
fi

echo "call from outside"