# church_tool

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application that follows the
[simple app state management
tutorial](https://flutter.dev/docs/development/data-and-backend/state-mgmt/simple).

For help getting started with Flutter development, view the
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Assets

The `assets` directory houses images, fonts, and any other files you want to
include with your application.

The `assets/images` directory contains [resolution-aware
images](https://flutter.dev/docs/development/ui/assets-and-images#resolution-aware).

## Localization

This project generates localized messages based on arb files found in
the `lib/localization` directory.

Run `flutter gen-l10n` for regeneration.

To support additional languages, please visit the tutorial on
[Internationalizing Flutter
apps](https://flutter.dev/docs/development/accessibility-and-localization/internationalization)


## Analytics

Current we are using PostHog tool to do analytics. However, Android
and iOS still yet to properly setup via the AndroidManifest.xml and 
Info.plist file respectively.

```
<manifest xmlns:android="http://schemas.android.com/apk/res/android" package="com.example.posthog_flutter_example">
    <application>
        <activity>
            [...]
        </activity>
        <meta-data android:name="com.posthog.posthog.API_KEY" android:value="YOUR_API_KEY_GOES_HERE" />
        <meta-data android:name="com.posthog.posthog.POSTHOG_HOST" android:value="https://app.posthog.com" />
        <meta-data android:name="com.posthog.posthog.TRACK_APPLICATION_LIFECYCLE_EVENTS" android:value="true" />
        <meta-data android:name="com.posthog.posthog.DEBUG" android:value="true" />
    </application>
</manifest>
```

```
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	[...]
	<key>com.posthog.posthog.API_KEY</key>
	<string>YOUR_API_KEY_GOES_HERE</string>
	<key>com.posthog.posthog.POSTHOG_HOST</key>
	<string>https://app.posthog.com</string>
	<key>com.posthog.posthog.CAPTURE_APPLICATION_LIFECYCLE_EVENTS</key>
	<true/>
	<key>com.posthog.posthog.DEBUG</key>
	<true/>
	[...]
</dict>
</plist>
```