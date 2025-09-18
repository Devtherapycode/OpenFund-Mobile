# OpenFund Mobile

A Flutter-based mobile application for supporting content creators through donations.

## Overview

OpenFund is a donation platform that enables fans to support their favorite streamers and YouTubers. Built with Flutter for iOS and Android.

## Getting Started

### Prerequisites

- Flutter SDK (3.7.2 or higher)
- Dart SDK
- iOS/Android development environment setup

### Installation

1. Clone the repository
```bash
git clone https://github.com/Devtherapycode/OpenFund-Mobile.git
cd openfund_mobile
```

2. Install dependencies
```bash
flutter pub get
```

3. Run the app
```bash
flutter run
```

## Project Structure

The project follows clean architecture principles:

- `lib/core/` - Core utilities, constants, and shared components
- `lib/data/` - Data layer implementation
- `lib/domain/` - Business logic and entities
- `lib/application/` - Application services and state management
- `lib/presentation/` - UI components and pages

## Technologies

- **Flutter** - Cross-platform framework
- **Provider** - State management
- **GoRouter** - Navigation
- **GetIt** - Dependency injection
- **HTTP** - Network requests

## Development

### Running Tests
```bash
flutter test
```

### Building for Production

#### iOS
```bash
flutter build ios
```

#### Android
```bash
flutter build apk
```

## Contributing

Please feel free to submit a Pull Request or open any issue if you find bugs or have suggestions.

## License

This project is licensed under the MIT License.