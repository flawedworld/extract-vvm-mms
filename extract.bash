#!/bin/bash

set -o errexit -o nounset -o pipefail

APPS=(com.google.android.dialer com.google.android.apps.messaging)

# Pull apks from stock OS and dump them
for app in ${APPS[@]}; do
    rm -rf $app
    mkdir $app
    for package in $(adb shell pm path $app); do
        adb pull ${package#package:} $app/
    done
    java -jar ./jar/apktool-cli-all.jar decode $app/base.apk -o $app/dump
done

# Copy VVM config
mkdir -p platform_packages_apps_Dialer/java/com/android/voicemail/impl/res/xml/
cp com.google.android.dialer/dump/res/xml/vvm_config.xml platform_packages_apps_Dialer/java/com/android/voicemail/impl/res/xml/vvm_config.xml

# Copy MMS configs
mkdir -p platform_packages_apps_Messaging/res/
cp -r com.google.android.apps.messaging/dump/res/xml-mcc* platform_packages_apps_Messaging/res/
# Remove vendor specific configs, this is usually for Huawei, Motorola or LG only and is not relevant to us
rm -r platform_packages_apps_Messaging/res/xml-mcc*/*_config_override.xml
