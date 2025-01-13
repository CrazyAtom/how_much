# Used Item Price Analysis and Sales Strategy App

A mobile application powered by AI that analyzes used item prices and provides optimal sales strategies.

## Key Features

**Product Analysis**

- Upload used item images and descriptions
- Real-time price analysis using Google Gemini AI
- Data-driven personalized sales strategy
- Analysis results in JSON format

**User Management**

- Firebase Authentication-based user verification
- Guest login support
- Social login support (Google, Apple)
- Secure user data management via Flutter Secure Storage

**Data Management**

- Analysis data storage through Firebase Realtime Database
- View and manage analysis history

## Tech Stack

- **Framework**: Flutter (SDK ^3.5.4)
- **AI Model**: Google Gemini
- **Backend Service**: Google Firebase
- **Database**: Firebase Realtime Database
- **Authentication**: Firebase Authentication
- **State Management**: Flutter Riverpod

## Dependencies

**Core Dependencies**

```yaml
flutter_riverpod: ^2.6.1
go_router: ^14.6.2
google_generative_ai: ^0.4.6
firebase_core: ^3.8.1
firebase_auth: ^5.3.4
flutter_secure_storage: ^9.2.2
```

**UI Components**

```yaml
flutter_svg: ^2.0.16
flutter_markdown: ^0.7.4
fl_chart: ^0.69.2
flutter_animate: ^4.5.2
shimmer: ^3.0.0
loading_animation_widget: ^1.3.0
google_fonts: ^6.2.1
```

**Development Tools**

```yaml
build_runner: ^2.4.13
json_serializable: ^6.9.0
freezed: ^2.5.7
riverpod_generator: ^2.6.3
flutter_lints: ^5.0.0
```

## Installation & Setup

```bash
# Clone project
git clone [repository URL]

# Install dependencies
flutter pub get

# Run code generation
flutter pub run build_runner build
```

## Environment Configuration

1. Create `.env` file and enter the following information:

```plaintext
GEMINI_API_KEY=your_api_key_here
```

2. Firebase Project Setup:

```dart
// Configure in firebase_options.dart file
```

## Running the Application

```bash
# Run in debug mode
flutter run

# Run in release mode
flutter run --release
```

## Project Structure

```plaintext
lib/
├── main.dart
├── config/
├── models/
├── services/
│   ├── gemini_service.dart
│   ├── firebase_service.dart
│   └── auth_service.dart
├── screens/
└── widgets/
```

## License

This project is licensed under the MIT License.
