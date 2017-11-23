# Thanks @djacobs https://gist.github.com/djacobs/2411095

PROVISIONING_PROFILE="$HOME/Library/MobileDevice/Provisioning Profiles/TCS_Distribution_Profile_16To17.mobileprovision"
OUTPUTDIR="$PWD/build/Release-iphoneos"
RELEASE_DATE=`date '+%Y-%m-%d %H:%M:%S'`
RELEASE_NOTES="Build: $TRAVIS_BUILD_NUMBER\nUploaded: $RELEASE_DATE"

echo "********************"
echo "*     Signing      *"
echo "********************"
#xcrun -log -sdk iphoneos PackageApplication "$OUTPUTDIR/$APP_NAME.app" -o "$OUTPUTDIR/$APP_NAME.ipa" -sign "$DEVELOPER_NAME" -embed "$PROVISIONING_PROFILE"

RELEASE_NOTES="Build: $TRAVIS_BUILD_NUMBER\nUploaded: $RELEASE_DATE"

zip -r -9 "$OUTPUTDIR/$APP_NAME.app.dSYM.zip" "$OUTPUTDIR/$APP_NAME.app.dSYM"

mkdir -p "$OUTPUTDIR/Payload"
cp -R "$OUTPUTDIR/$APP_NAME.app" "$OUTPUTDIR/Payload/"
#zip -r -s 64 Payload.zip Payload/
zip -r -9 "$OUTPUTDIR/Payload.zip" "$OUTPUTDIR/Payload"

ls "$OUTPUTDIR"
mv Payload.zip "$APP_NAME.ipa"
ls "$OUTPUTDIR"
  
curl https://rink.hockeyapp.net/api/2/apps/$HOCKEY_APP_ID/app_versions \
  -F status="2" \
  -F notify="0" \
  -F notes="$RELEASE_NOTES" \
  -F notes_type="0" \
  -F ipa="@$OUTPUTDIR/$APP_NAME.ipa" \
  -F dsym="@$OUTPUTDIR/$APP_NAME.app.dSYM.zip" \
  -H "X-HockeyAppToken: $HOCKEY_APP_TOKEN"
  
  echo "** build completed **"
