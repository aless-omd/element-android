#!/bin/bash

# OMD Messenger Production Build Script
# This script builds the production version of OMD Messenger for Play Store deployment

set -e

echo "🚀 Building OMD Messenger for Production"
echo "========================================"

# Check if we're in the right directory
if [ ! -f "build.gradle" ]; then
    echo "❌ Error: Please run this script from the root of the element-android project"
    exit 1
fi

# Check if keystore exists or environment variables are set
if [ -z "$OMD_ANDROID_KEYSTORE" ] && [ ! -f "./signature/omd.keystore" ]; then
    echo "⚠️  Warning: No production keystore found!"
    echo "   Set OMD_ANDROID_KEYSTORE environment variable or create ./signature/omd.keystore"
    echo "   See ./signature/README.md for instructions"
    echo ""
    echo "   Using debug signing for now..."
fi

# Clean previous builds
echo "🧹 Cleaning previous builds..."
./gradlew clean

# Build the production AAB (Android App Bundle) for Play Store
echo "📦 Building production AAB for Play Store..."
./gradlew bundleGplayOmd

# Build the production APK
echo "📱 Building production APK..."
./gradlew assembleGplayOmd

# Show build results
echo ""
echo "✅ Build completed successfully!"
echo ""
echo "📁 Build outputs:"
echo "   AAB (Play Store): $(find . -name "*gplay-omd*.aab" | head -1)"
echo "   APK (Direct):     $(find . -name "*gplay-omd*.apk" | head -1)"
echo ""
echo "🎯 Next steps:"
echo "   1. Test the APK on a device"
echo "   2. Upload the AAB to Google Play Console"
echo "   3. Complete the Play Store listing with OMD branding"
echo ""
echo "📋 Version info:"
./gradlew -q printVersionName | grep -E "gplayOmd"