# Extractor for Visual Voicemail and MMS configurations from the stock OS

Google no longer maintains MMS or Visual Voicemail configuration files within AOSP.

This means that projects and vendors which do not ship the Google Dialer and 
Google Messaging apps, cannot get valid or working configurations for carriers.

Instead, this script extracts the apks from a connected device, uses Apktool to
dump them, and then prepares a directory structure to copy into your repos of the AOSP Dialer
and Messaging apps.

# Usage

Java and ADB must be installed into your environment.

```./extract.bash```

Assume $AOSPTREE is referring to the root directory of your AOSP tree.

In your AOSP tree, perform the following in order to remove the AOSP configurations.

```rm -r $AOSPTREE/packages/apps/Dialer/java/com/android/voicemail/impl/res/xml/vvm_config.xml```

```rm -r $AOSPTREE/packages/apps/Messaging/res/xml-mcc*```

Then copy the generated configurations to the AOSP repos.

```cp -r platform_packages_apps_Dialer/* $AOSPTREE/packages/apps/Dialer/```

```cp -r platform_packages_apps_Messaging/* $AOSPTREE/packages/apps/Messaging/```

