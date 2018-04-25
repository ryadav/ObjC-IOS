#!/bin/sh
security delete-keychain ios-build.keychain
rm -f ~/Library/MobileDevice/Provisioning\ Profiles/$PROFILE_NAME.mobileprovision


jsonValue= `jq '.name' customConfiguration.json`
echo $jsonValue
echo "my name appear here rahul yadav"
