# Afinz Technical Challenge (Flutter)

This project is a solution for the Afinz technical challenge. It uses **Flutter**, **Clean Architecture**, **BLoC**, and **Dependency Injection** via `get_it`.

## Project Structure

- `core/`: Common error handling, dependency injection, and shared logic
- `features/`: Organized by modules (balance, transfer, profile), following clean layers (data, domain, presentation)
- `shared/`: Reusable widgets and theme configuration

## 🔐 Environment Variables

This app uses `dart-define` to inject environment variables:

```bash
flutter run --dart-define=API_TOKEN=TOKEN-TEST-AFINZ

## Getting Started

```bash
flutter pub get
flutter run
