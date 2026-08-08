# CI/CD Setup Guide

This document provides instructions for setting up and configuring the CI/CD workflows for ballast_flutter_example.

## Overview

The CI/CD workflows live in the repository root under `.github/workflows/` and run from the `ballast_flutter_example` working directory. They include:

- **Lint Workflow** (`flutter-lint.yml`): Runs `flutter analyze` on pull requests and pushes
- **Format Workflow** (`flutter-format.yml`): Checks code formatting with `dart format`
- **Test Workflow** (`flutter-test.yml`): Runs unit tests
- **Build Workflows**: Platform-specific build workflows for enabled platforms

## Prerequisites

1. **GitHub Actions enabled**: Ensure GitHub Actions are enabled in your repository settings
2. **Flutter Configuration**: Set Flutter channel and version secrets (optional, defaults to `stable` channel)

## Configuration

### GitHub Secrets

Go to **Settings → Secrets → Actions** and create the following secrets:

| Secret | Value | Description | Required |
|--------|-------|-------------|----------|
| `FLUTTER_CHANNEL` | `stable`, `beta`, or `dev` | Flutter channel to use in workflows. Defaults to `stable` if not set. | No |
| `FLUTTER_VERSION` | Specific version (e.g., `3.24.0`) or empty | Flutter SDK version to use. If not set, defaults to the Flutter version that was installed when the project was created (3.44.8). Examples: `3.24.0`, `3.24.1`, `3.25.0`. Check [Flutter releases](https://docs.flutter.dev/release/archive) for available versions. | No |
| `CODECOV_TOKEN` | Codecov upload token | Token for uploading test coverage reports to Codecov. See [Codecov Token Setup](#codecov-token-setup) below for instructions. | No |

**Note**: If `FLUTTER_VERSION` is not set, the workflow will use the Flutter version that was installed when the project was created (3.44.8) as the default. Setting a specific version ensures consistent builds across all CI runs and allows you to override the default version.

### Codecov Token Setup

To enable test coverage reporting in pull requests, you'll need to set up a Codecov token:

1. **Sign in to Codecov**:
   - Go to [codecov.io](https://codecov.io) and sign in with your GitHub account
   - Grant Codecov access to your repository when prompted

2. **Get your upload token**:
   - Navigate to your repository on Codecov (or go to **Settings → Integrations**)
   - Copy your repository's upload token (it will look like: `xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx`)

3. **Add the secret to GitHub**:
   - Go to your repository on GitHub
   - Navigate to **Settings → Secrets and variables → Actions**
   - Click **New repository secret**
   - Name: `CODECOV_TOKEN`
   - Value: Paste your Codecov upload token
   - Click **Add secret**

**Note**: The Codecov token is optional. The test workflow will still run tests without it, but coverage reports won't be uploaded to Codecov. If you don't plan to use Codecov, you can skip this step.

### Additional Secrets (for App Store Deployment)

If you plan to deploy to app stores or use code signing, you'll need to configure additional secrets:

#### iOS App Store Connect (for TestFlight/App Store deployment)

1. Go to [App Store Connect API Keys](https://appstoreconnect.apple.com/access/api)
2. Create a new API key
3. Download the `.p8` file (⚠️ only available once!)
4. Convert to Base64:
   ```bash
   base64 -i AuthKey_ABC12345.p8 | pbcopy
   ```
5. Add the following secrets in **Settings → Secrets → Actions**:

| Secret | Description |
|--------|-------------|
| `APPLE_NOTARY_KEY_ID` | Key ID (example: ABC123DEFG) |
| `APPLE_NOTARY_ISSUER_ID` | Issuer ID (UUID on App Store Connect) |
| `APPLE_NOTARY_KEY_BASE64` | Base64 of the `.p8` key |

#### Google Play Console (for Play Store deployment)

1. Go to [Google Play Console](https://play.google.com/console)
2. Navigate to **Setup → API access**
3. Create a service account
4. Download the JSON key file
5. Add the following secret in **Settings → Secrets → Actions**:

| Secret | Description |
|--------|-------------|
| `GOOGLE_PLAY_SERVICE_ACCOUNT_JSON` | Contents of the JSON key file |

## Workflow Triggers

### Automatic Triggers

- **Lint, Format, Test**: Run on pull requests and pushes to `main` branch
- **Build Workflows**: Run on version tags (`v*.*.*`) only — not on every push to `main`

### Manual Triggers

All build workflows can be triggered manually via **Actions → [Workflow Name] → Run workflow**

## Platform-Specific Notes

### iOS
- Requires macOS runner
- Builds are unsigned by default
- For code signing, configure Apple Developer certificates

### Android
- Builds both APK and AAB formats
- Requires Java 17
- For Play Store deployment, configure Google Play Console API

## Troubleshooting

### Common Issues

1. **Workflow fails with "Flutter not found" or version error**
   - Ensure the `FLUTTER_CHANNEL` secret is set correctly (`stable`, `beta`, or `dev`)
   - If using `FLUTTER_VERSION`, verify the version exists for the specified channel
   - Check [Flutter releases](https://docs.flutter.dev/release/archive) for valid version numbers
   - If `FLUTTER_VERSION` is set incorrectly, remove it to use the latest version from the channel

2. **Build fails on specific platform**
   - Verify that the platform is enabled in your `pubspec.yaml`
   - Check platform-specific dependencies are installed

3. **Dependabot not creating PRs**
   - Ensure Dependabot is enabled in repository settings
   - Check that the root `.github/dependabot.yml` includes `/ballast_flutter_example`

### Getting Help

- Check workflow logs in the **Actions** tab
- Review Flutter documentation for platform-specific requirements
- Consult GitHub Actions documentation for workflow syntax

## Security Best Practices

1. **Never commit secrets**: Always use GitHub Secrets for sensitive information
2. **Review Dependabot PRs**: Regularly review and merge dependency updates
3. **Limit workflow permissions**: Use minimal required permissions in workflows
4. **Regular updates**: Keep GitHub Actions versions up to date

## Next Steps

1. Set up repository variables (if needed)
2. Configure secrets (if deploying to app stores)
3. Push your code to trigger workflows
4. Monitor workflow runs in the **Actions** tab
