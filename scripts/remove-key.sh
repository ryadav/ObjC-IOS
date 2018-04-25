#!/bin/sh
security delete-keychain ios-build.keychain
rm -f ~/Library/MobileDevice/Provisioning\ Profiles/$PROFILE_NAME.mobileprovision


jsonValue= cat ./scripts/customConfiguration.json | jq '.isCreateBuild'
if [ "$jsonValue" = true ] ; then
    echo 'json value read as yes'
fi
