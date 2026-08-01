# ballast_flutter_example

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## flutter-setup

### Quickstart
```bash
flutter pub get
make run-ios         # runs on iOS simulator
```

### Testing
```bash
make test           # unit + widget tests
```

### End-to-End Testing
```bash
make integration    # Flutter SDK integration_test/
```

### Linting
```bash
make analyze
```

### Env vars
Copy `.env.example` to `.env` and fill in values. The file is gitignored and
not bundled as an asset by default, so `dotenv.env['KEY']` returns null until
you either add `.env` to `pubspec.yaml` assets (and remove it from `.gitignore`),
or use `--dart-define-from-file=.env.json` for build-time injection.

### Scaffold configuration
- Architecture: `basic`
- Database: `none`
- Testing: `standard`
- End-to-end testing: `integration_test`
- Auth provider: `none`
- Cloud database: `none`
- Notifications: `none`
