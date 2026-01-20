# PetHub-Mobile

PetHub-Mobile is a Flutter mobile application for pet owners to browse and buy pet products, book daycare services, and view pet-care videos.

## Overview

- **Product Marketplace**: Browse and purchase food, toys, grooming supplies, clothes, and accessories.
- **Daycare & Services Booking**: Book daycare and service slots for pets with selectable options.
- **Pet Care Tips**: Watch curated YouTube videos and tutorials for grooming, training, and pet health.

## Repository

Clone the repository:

```bash
git clone https://github.com/NidukSuraweeraArachchi/PetHub-Mobile.git
cd PetHub-Mobile
git checkout mobile-v2
```

## Prerequisites

- Flutter SDK (see https://flutter.dev/docs/get-started/install)
- An editor (VS Code or Android Studio)
- Android/iOS toolchains configured for device/emulator

## Install & Run

```bash
flutter pub get
flutter run
```

For platform-specific runs (Android/iOS), open the respective platform project in Android Studio or Xcode.

## Project Structure (high level)

- `lib/` — app source code
  - `authentication/` — login, phone, verification screens
  - `1_home_screens/` — home categories and content
  - `2_bottom_nav_screens/` — main tabs (home, product, package, user, etc.)
  - `navigation/` — maps and route-related UI
  - `main.dart` — app entrypoint
- `assets/` — images and static resources
- `android/`, `ios/`, `macos/`, `linux/`, `windows/`, `web/` — platform projects
- `test/` — widget and unit tests

## Notable Files

- `lib/main.dart` — app startup and dependency initialization
- `lib/firebase_options.dart` — Firebase configuration (auto-generated)
- `assets/` — ships product and UI images used by the app

## Contributing

Contributions are welcome. Typical workflow:

1. Fork the repo and create a branch.
2. Make changes and add tests where appropriate.
3. Open a pull request with a clear description of your changes.

Please ensure code follows existing style and include small, focused commits.

## License

This project uses the MIT License. See the `LICENSE` file for details.

## Contact

Open issues in the repository for bugs or feature requests.
