# OMD Messenger Signing Configuration

## Keystore Setup

To create a production keystore for the OMD Messenger app:

```bash
# Navigate to the signature directory
cd signature

# Generate a new keystore (replace with your actual details)
keytool -genkey -v -keystore omd.keystore -alias omdrelease -keyalg RSA -keysize 2048 -validity 10000

# You'll be prompted for:
# - Keystore password (remember this!)
# - Key password (remember this!)
# - Your name and organization details
```

## Configuration Options

### Option 1: Environment Variables (Recommended for CI/CD)
Set these environment variables:
- `OMD_ANDROID_KEYSTORE`: Path to your keystore file
- `OMD_ANDROID_KEYID`: Key alias (e.g., "omdrelease")
- `OMD_ANDROID_KEYPASSWORD`: Key password
- `OMD_ANDROID_STOREPASSWORD`: Keystore password

### Option 2: Gradle Properties
Add to your `~/.gradle/gradle.properties` or local `gradle.properties`:
```properties
signing.omd.storePath=./signature/omd.keystore
signing.omd.keyId=omdrelease
signing.omd.keyPassword=YOUR_KEY_PASSWORD
signing.omd.storePassword=YOUR_STORE_PASSWORD
```

## Building for Production

Once configured, build the production OMD variant:

```bash
# Build the production APK
./gradlew assembleGplayOmd

# Build the production AAB for Play Store
./gradlew bundleGplayOmd
```

## Security Notes

- Never commit keystore files to version control
- Store passwords securely (use environment variables in CI/CD)
- Back up your keystore file safely - you cannot recover it if lost
- The keystore is required for all future app updates

## Default Development Setup

If no signing configuration is provided, the build will fall back to:
- Keystore: `./signature/omd.keystore`
- Alias: `omddebugkey`
- Passwords: `android` (development only)