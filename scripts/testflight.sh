# Thanks @djacobs https://gist.github.com/djacobs/2411095

PROVISIONING_PROFILE="$HOME/Library/MobileDevice/Provisioning Profiles/TCS_Distribution_Profile_16To17.mobileprovision"
OUTPUTDIR="$PWD/build/Release-iphoneos"
RELEASE_DATE=`date '+%Y-%m-%d %H:%M:%S'`
RELEASE_NOTES="Build: $TRAVIS_BUILD_NUMBER\nUploaded: $RELEASE_DATE"

echo "********************"
echo "*     Signing      *"
echo "********************"
#xcodebuild -sdk iphoneos PackageApplication "$OUTPUTDIR/$APP_NAME.app" -o "$OUTPUTDIR/$APP_NAME.ipa" -sign "$DEVELOPER_NAME" -embed "$PROVISIONING_PROFILE"

#xcodebuild archive -project ObjC-IOS.xcodeproj -scheme ObjC-IOS -archivePath "$OUTPUTDIR/ObjC-IOS.xcarchive"

#xcodebuild -exportArchive -archivePath "$OUTPUTDIR/ObjC-IOS.xcarchive" -exportPath "$OUTPUTDIR/" -exportFormat ipa -exportProvisioningProfile "$PROVISIONING_PROFILE"
#xcodebuild -exportArchive -archivePath "$OUTPUTDIR/ObjC-IOS.xcarchive" -exportPath "$OUTPUTDIR/ObjC-IOS.ipa" -exportOptionsPlist "$HOME/Library/exportOptions.plist"


RELEASE_NOTES="Build: $TRAVIS_BUILD_NUMBER\nUploaded: $RELEASE_DATE"

zip -r -9 "$OUTPUTDIR/$APP_NAME.app.dSYM.zip" "$OUTPUTDIR/$APP_NAME.app.dSYM"

mkdir -p "$OUTPUTDIR/Payload"
cp -R "$OUTPUTDIR/$APP_NAME.app" "$OUTPUTDIR/Payload/"
#zip -r -s 64 Payload.zip Payload/
zip -r -9 "$OUTPUTDIR/Payload.zip" "$OUTPUTDIR/Payload"

ls "$OUTPUTDIR/Payload"
echo "** **"
mv "$OUTPUTDIR/Payload.zip" "$OUTPUTDIR/$APP_NAME.ipa"
ls "$OUTPUTDIR"
mv "$OUTPUTDIR/$APP_NAME.ipa" "$OUTPUTDIR/Payload1.zip"
unzip -r -9 "$OUTPUTDIR/Payload1" "$OUTPUTDIR/Payload1.zip"

echo "** **"
ls "$OUTPUTDIR/Payload1"
  
curl https://rink.hockeyapp.net/api/2/apps/$HOCKEY_APP_ID/app_versions \
  -F status="2" \
  -F notify="0" \
  -F notes="$RELEASE_NOTES" \
  -F notes_type="0" \
  -F ipa="@$OUTPUTDIR/$APP_NAME.ipa" \
  -F dsym="@$OUTPUTDIR/$APP_NAME.app.dSYM.zip" \
  -H "X-HockeyAppToken: $HOCKEY_APP_TOKEN"
  
  echo "** build completed **"
