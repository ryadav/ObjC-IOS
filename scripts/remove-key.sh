#!/bin/sh
security delete-keychain ios-build.keychain
rm -f ~/Library/MobileDevice/Provisioning\ Profiles/$PROFILE_NAME.mobileprovision


jsonValue= cat ./scripts/customConfiguration.json | jq '.isCreateBuild'
if $jsonValue ; then
    echo "This is a pull request. No deployment will be done."
fi

echo "call from outside"