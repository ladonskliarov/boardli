# Boardli Mobile

Boardli Mobile: Empowering employee onboarding with AI. A high-performance Flutter app built to make the first days at a new job smarter, faster, and more engaging.

## Overview

Boardli Mobile provides two role-specific app experiences:

- **Company flow**: company registration/login, company account, organization management (employees + departments), and knowledge base management.
- **Employee flow**: employee registration/login, employee account, AI chat assistant, and knowledge base browsing.

The app is built with a feature-oriented structure and uses BLoC/Cubit for presentation logic, GetIt for DI, and Dio for networking.

## Tech Stack

- Flutter + Dart
- BLoC / `flutter_bloc` for state management
- `get_it` for dependency injection and service locator
- `go_router` for navigation
- `dio` for HTTP requests
- `flutter_secure_storage` + `shared_preferences` for local storage
- `easy_localization` for i18n
- `dartz` for functional error handling (`Either`)
- e-Ukraine custom font family

## Prerequisites

- Flutter SDK compatible with Dart `^3.10.8` (see `pubspec.yaml`)
- Dart SDK `^3.10.8`
- Xcode + CocoaPods (for iOS)
- Android Studio / Android SDK + emulator or device (for Android)
- Git

Check your setup:

```bash
flutter --version
flutter doctor -v
```

## Getting Started

### 1) Clone the repository

```bash
git clone <your-repo-url>
cd boardli
flutter pub get
```

### 2) Run the app

```bash
flutter run
```

## Configuration and Environment

This project currently does **not** load environment variables from `.env` files.

### Current runtime config location

- `lib/core/di/injection_container.dart`
  - Contains the current `Dio` `baseUrl` value.
  - Registers interceptors, repositories, cubits, and providers.

### Existing config files

- `pubspec.yaml` - dependencies, assets, fonts, SDK constraints.
- `analysis_options.yaml` - lint rules (`flutter_lints` preset).
- `native_splash.yaml` - splash screen setup for `flutter_native_splash`.
- `assets/translations/en.json`, `assets/translations/uk.json` - i18n dictionaries.

### Suggested environment keys (for future externalization)

No real values below; these are placeholders for future config extraction:

- `API_BASE_URL` - backend base URL for all REST API requests.
- `LOG_NETWORK_PAYLOADS` - enable/disable verbose network logging.
- `APP_ENV` - environment marker (`dev`, `staging`, `prod`).

Recommended delivery options:

- `--dart-define` flags for build/run
- `--dart-define-from-file` (Flutter-supported)
- separate flavor entrypoints

## Run on iOS / Android

### iOS

```bash
flutter pub get
cd ios && pod install && cd ..
flutter run -d ios
```

Or select a simulator/device from your IDE and run.

### Android

```bash
flutter pub get
flutter run -d android
```

Or choose a connected Android device/emulator in your IDE.

## Build Commands

```bash
# Debug run
flutter run

# Analyze code
flutter analyze

# Run tests
flutter test

# Production builds
flutter build apk
flutter build appbundle
flutter build ios

# Optional: generate native splash from native_splash.yaml
dart run flutter_native_splash:create
```

## Project Structure

```text
boardli/
├─ lib/
│  ├─ core/
│  │  ├─ di/                    # GetIt registration and bootstrapping
│  │  ├─ router/                # GoRouter config + auth redirects
│  │  ├─ interceptors/          # Dio auth interceptor
│  │  ├─ storage/               # secure storage + shared preferences
│  │  ├─ providers/             # theme and locale providers
│  │  ├─ style/                 # theme, colors, dimensions, reusable widgets
│  │  ├─ error/                 # Failure models
│  │  └─ util/                  # enums, validators, extensions
│  └─ features/
│     ├─ auth/
│     ├─ company_account/
│     ├─ employee_account/
│     ├─ company_management/
│     ├─ knowledge_base/
│     ├─ chat_assistant/
│     └─ dashboard/
├─ assets/
│  ├─ icons/
│  └─ translations/
├─ android/
├─ ios/
└─ pubspec.yaml
```

## Feature Summary

- **Authentication**
  - Company login/register (`/api/v1/auth/company/login`, `/api/v1/auth/company/register`)
  - Employee login/register (`/api/v1/auth/employee/login`, `/api/v1/auth/employee/register`)
  - Role-aware auth state via `AuthCubit`
- **Company Account**
  - Fetch company profile from `/api/v1/auth/me`
- **Employee Account**
  - Fetch employee profile from `/api/v1/auth/me`
  - Avatar URL from `/api/v1/ai/avatar-url`
- **Company Management**
  - Employees list, departments list, create department, invite/delete employee
- **Knowledge Base**
  - Browse, upload by URL/file, delete resources
- **Chat Assistant**
  - AI chat and chat history (`/api/v1/ai/chat`, `/api/v1/ai/history`)
- **UX**
  - Light/dark mode persistence
  - English/Ukrainian localization

## Notes

- The app uses JWT bearer token attachment through `TokenInterceptor`.
- Auth bootstrapping is performed in `main.dart` via `sl<AuthCubit>().checkAuth()`.
- Current codebase has no CI workflow file in `.github/workflows`.
