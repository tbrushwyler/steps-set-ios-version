#!/bin/bash

# exit if a command fails
set -e
#
# Required parameters
if [ -z "${info_plist_file}" ] ; then
  echo " [!] Missing required input: info_plist_file"
  exit 1
fi
if [ ! -f "${info_plist_file}" ] ; then
  echo " [!] File Info.plist doesn't exist at specified path: ${info_plist_file}"
  exit 1
fi

# ---------------------
# --- Configs:

echo " (i) Provided Info.plist file path: ${info_plist_file}"
echo " (i) Provided Bundle Version: ${bundle_version}"
echo " (i) Provided Bundle Short Version String: ${bundle_version_short}"
echo " (i) Provided append version: ${append_version}"

# ---------------------
# --- Main:

# verbose / debug print commands
#set -v

# ---- Set Info.plist Bundle version:
echo ""
echo ""
echo " (i) Replacing version..."

/usr/libexec/PlistBuddy -c "Set :CFBundleVersion ${bundle_version}" "${info_plist_file}"

REPLACED_BUNDLE_VERSION="$(/usr/libexec/PlistBuddy -c "Print :CFBundleVersion" "${info_plist_file}")"
echo " (i) Replaced Bundle Version: $REPLACED_BUNDLE_VERSION"

envman add --key APP_VERSION --value "${REPLACED_BUNDLE_VERSION}"

# ==> Bundler version patched in Info.plist file for iOS project
