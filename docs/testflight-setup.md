# TestFlight Automation Setup Guide

This guide explains how to set up the automated TestFlight distribution system for pull requests.

## Overview

When a pull request is created or updated, GitHub Actions will automatically:
1. Build the iOS app using Flutter
2. Archive and code sign the app
3. Upload to TestFlight
4. Comment on the PR with build status

## Required GitHub Secrets

You need to configure the following secrets in your GitHub repository settings:

### Apple Developer Certificates

1. **APPLE_CERTIFICATE_BASE64**
   - Export your iOS distribution certificate (.p12) from Keychain Access
   - Convert to base64: `base64 -i certificate.p12 | pbcopy`
   - Paste the base64 string as the secret value

2. **APPLE_CERTIFICATE_PASSWORD**
   - The password used when exporting the .p12 certificate

3. **APPLE_PROVISIONING_PROFILE_BASE64**
   - Download your App Store provisioning profile from Apple Developer Portal
   - Convert to base64: `base64 -i profile.mobileprovision | pbcopy`
   - Paste the base64 string as the secret value

### App Store Connect API

4. **APP_STORE_CONNECT_API_KEY_ID**
   - Create an API key in App Store Connect (Users and Access → Keys)
   - Use the Key ID (e.g., "2X9R4HXF34")

5. **APP_STORE_CONNECT_API_ISSUER_ID**
   - Found in App Store Connect (Users and Access → Keys)
   - Copy the Issuer ID (UUID format)

6. **APP_STORE_CONNECT_API_KEY_BASE64**
   - Download the .p8 key file from App Store Connect
   - Convert to base64: `base64 -i AuthKey_XXXXXXXXXX.p8 | pbcopy`
   - Paste the base64 string as the secret value

## Setup Steps

### 1. Apple Developer Account Setup

1. Ensure you have an active Apple Developer Program membership
2. Create an App Store Connect record for your app if it doesn't exist
3. Configure your app's bundle identifier: `com.yuto.smooth.metronome`

### 2. Certificates and Provisioning Profiles

1. Create an iOS Distribution certificate in Apple Developer Portal
2. Create an App Store provisioning profile for your app
3. Download both and convert to base64 as described above

### 3. App Store Connect API Key

1. Go to App Store Connect → Users and Access → Keys
2. Click the "+" button to create a new API key
3. Give it a name (e.g., "CI/CD TestFlight")
4. Select "Developer" role
5. Download the .p8 file and note the Key ID and Issuer ID

### 4. GitHub Repository Configuration

1. Go to your repository settings → Secrets and variables → Actions
2. Add all the required secrets listed above
3. Ensure the secrets are available to the workflow

### 5. Team Configuration (Optional)

Update the `ios/fastlane/Appfile` with your team information:
```ruby
apple_id("your-apple-id@example.com")
itc_team_id("YOUR_APP_STORE_CONNECT_TEAM_ID")
team_id("YOUR_DEVELOPER_PORTAL_TEAM_ID")
```

## Testing the Setup

1. Create a test pull request with a small change
2. Check the Actions tab to see if the workflow runs
3. Monitor the build logs for any issues
4. Verify that TestFlight receives the build

## Troubleshooting

### Common Issues

1. **Certificate Expired**
   - Renew your iOS Distribution certificate
   - Update the APPLE_CERTIFICATE_BASE64 secret

2. **Provisioning Profile Invalid**
   - Ensure the profile includes the correct certificate
   - Regenerate and update APPLE_PROVISIONING_PROFILE_BASE64

3. **API Key Issues**
   - Verify the API key has the correct permissions
   - Check that the Key ID and Issuer ID match

4. **Build Failures**
   - Check Flutter version compatibility
   - Ensure all dependencies are available
   - Review the workflow logs for specific errors

### Debug Tips

- Check the GitHub Actions logs for detailed error messages
- Verify all secrets are properly configured and accessible
- Test certificates and profiles locally with Xcode first
- Use the workflow's failure comments to identify issues quickly

## Security Considerations

- Never commit certificates or API keys to the repository
- Regularly rotate API keys and certificates
- Limit API key permissions to only what's needed
- Monitor access logs in App Store Connect
- Consider using different certificates for CI vs. local development

## Workflow Customization

The workflow can be customized by modifying:
- `.github/workflows/testflight-pr.yml` - Main workflow configuration
- `ios/fastlane/Fastfile` - Build and upload logic
- `ios/fastlane/Appfile` - App and team configuration

## Additional Resources

- [Fastlane Documentation](https://docs.fastlane.tools/)
- [App Store Connect API](https://developer.apple.com/documentation/appstoreconnectapi)
- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Flutter CI/CD Best Practices](https://docs.flutter.dev/deployment/cd)