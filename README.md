# Afinz Technical Challenge (Flutter)

This project is a solution to the Afinz technical challenge. It is developed in **Flutter** following **Clean Architecture**, with **BLoC** for state management and **GetIt** for dependency injection.

---

## Technologies Used

* Flutter
* Clean Architecture (Domain → Data → Presentation)
* BLoC for state management
* Dio for HTTP requests
* GetIt for dependency injection
* flutter\_dotenv for environment variable handling
* Mockito for unit testing

---

## Project Structure

```
lib/
├── core/               # Dependency injection, configs
├── features/
│   ├── profile/        # Profile API (data/domain/presentation)
│   ├── balance/        # Balance API (data/domain/presentation)
│   ├── transfer/       # Transfer logic and UI
│   └── app/            # Composed screens
├── shared/             # Reusable UI and styles
└── main.dart
```

---

## Getting Started

1. **Clone the repository**

```bash
git clone https://github.com/oleonardodeandrade/afinz_app.git
cd afinz_app
```

2. **Install dependencies**

```bash
flutter pub get
```

3. **Create a **\`\`** file** in the root:

```
API_TOKEN=TOKEN-TEST-AFINZ
BASE_URL=https://interview.mattlabz.tech
```

4. **Run the app**

```bash
flutter run
```

> You can also pass env variables via `dart-define`:

```bash
flutter run --dart-define=API_TOKEN=TOKEN-TEST-AFINZ --dart-define=BASE_URL=https://interview.mattlabz.tech
```

---

## Implemented Requirements

*

---

## Running Tests

```bash
flutter test
```

To regenerate mocks:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

---

## Notes

* All transfers go to agency `3212`, account `9073` as required.
* Login is skipped — authentication is handled via static token.
* If the API fails, error messages are displayed gracefully.
