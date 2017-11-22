# Thanks @djacobs https://gist.github.com/djacobs/2411095

PROVISIONING_PROFILE="$HOME/Library/MobileDevice/Provisioning Profiles/$PROFILE_UUID.mobileprovision"
OUTPUTDIR="$PWD/build/Release-iphoneos"
RELEASE_DATE=`date '+%Y-%m-%d %H:%M:%S'`
RELEASE_NOTES="Build: $TRAVIS_BUILD_NUMBER\nUploaded: $RELEASE_DATE"

echo "********************"
echo "*     Signing      *"
echo "********************"
xcodebuild -log -sdk iphoneos PackageApplication "$OUTPUTDIR/$APPNAME.app" -o "$OUTPUTDIR/$APPNAME.ipa" -sign "$DEVELOPER_NAME" -embed "$PROVISIONING_PROFILE"

RELEASE_NOTES="Build: $TRAVIS_BUILD_NUMBER\nUploaded: $RELEASE_DATE"

zip -r -9 "$OUTPUTDIR/$APPNAME.app.dSYM.zip" "$OUTPUTDIR/$APPNAME.app.dSYM"

  
curl http://testflightapp.com/api/builds.json \
 -F file="@$OUTPUTDIR/$APP_NAME.ipa" \
 -F dsym="@$OUTPUTDIR/$APP_NAME.app.dSYM.zip" \
 -F api_token="$TESTFLIGHT_API_TOKEN" \
 -F team_token="$TESTFLIGHT_TEAM_TOKEN" \
 -F distribution_lists='Internal' \
 -F notes="$RELEASE_NOTES"