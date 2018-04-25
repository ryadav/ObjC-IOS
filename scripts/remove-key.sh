#!/bin/sh
security delete-keychain ios-build.keychain
rm -f ~/Library/MobileDevice/Provisioning\ Profiles/$PROFILE_NAME.mobileprovision


jsonValue= cat ./scripts/customConfiguration.json | json select '.isCreateBuild'
echo $jsonValue
echo "my name appear here rahul yadav"
