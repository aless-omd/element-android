# OMD Messenger Android - Build Variant

This is the OMD (OptimizeMyDay) branded build variant of Element Android. 

## Quick Start - Production Build

For a production-ready build for Play Store deployment:

```bash
# Run the production build script
./build-omd-production.sh
```

This will create both APK and AAB files ready for distribution.

## Development Builds

For development and testing:

```bash
# Build OMD Debug variant  
./gradlew assembleGplayOmdDebug

# Install OMD Debug variant directly to device
./gradlew installGplayOmdDebug

# Build OMD Production variant
./gradlew assembleGplayOmd

# Build AAB for Play Store
./gradlew bundleGplayOmd
```

## OMD-Specific Configuration

The OMD build variant includes:

- **App Name**: "OMD Messenger" (release) / "OMD Messenger - dbg" (debug)
- **Application ID**: `com.optimizemyday.messenger`
- **Default Server**: `https://matrix.optimizemyday.ai`
- **URI Scheme**: `omdmessenger://`
- **Domains**: All Element.io domains replaced with optimizemyday.ai
- **Bug Reports**: Sent to `https://support.optimizemyday.ai/bugreports/submit`
- **Jitsi Domain**: `meet.optimizemyday.ai`

## File Structure

OMD-specific configuration is stored in:

```
vector-app/src/omd/              # OMD app-specific overrides
├── AndroidManifest.xml          # OMD manifest overrides
└── res/values/                  # OMD resource overrides

vector-config/src/omd/           # OMD configuration overrides  
└── res/values/
    ├── config.xml               # OMD server and service config
    └── urls.xml                 # OMD URL configuration

vector/src/omd/                  # OMD vector module overrides
└── AndroidManifest.xml          # OMD vector manifest overrides
```

## Production Signing

For Play Store deployment, you need to configure production signing:

1. **Create keystore**: See `signature/README.md` for instructions
2. **Set environment variables** (recommended for CI/CD):
   ```bash
   export OMD_ANDROID_KEYSTORE="/path/to/your/omd.keystore"
   export OMD_ANDROID_KEYID="your-key-alias"
   export OMD_ANDROID_KEYPASSWORD="your-key-password"
   export OMD_ANDROID_STOREPASSWORD="your-store-password"
   ```
3. **Or use gradle.properties**:
   ```properties
   signing.omd.storePath=./signature/omd.keystore
   signing.omd.keyId=omdrelease
   signing.omd.keyPassword=YOUR_KEY_PASSWORD
   signing.omd.storePassword=YOUR_STORE_PASSWORD
   ```

## Play Store Deployment

1. Build production AAB: `./gradlew bundleGplayOmd`
2. Upload to Google Play Console
3. Use metadata from `playstore/listing.md`
4. Submit for review

## Customization

To further customize the OMD build:

1. **Icons**: Add OMD-branded icons to `vector-app/src/omd/res/mipmap-*`
2. **Colors**: Override colors in `vector-app/src/omd/res/values/colors.xml`
3. **Strings**: Add string overrides in `vector-app/src/omd/res/values/strings.xml`
4. **Signing**: Configure OMD-specific signing in `build.gradle`

## Original Element Build

The original Element Android build variants are still available:

```bash
# Original Element variants
./gradlew assembleDebug          # Element - dbg
./gradlew assembleRelease        # Element  
./gradlew assembleNightly        # Element (nightly)
```

Both Element and OMD variants can coexist and be built from the same codebase.