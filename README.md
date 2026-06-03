# Article Feed

A small Flutter app that shows a "For You" list of articles you can save. It demonstrates a
clean, layered architecture with BLoC state management, a mock backend, responsive layout, and a
light/dark theme toggle.

## Features

- **Article feed** — a scrollable "For You" list of article cards (title, author, preview).
- **Save with BLoC** — tapping the bookmark saves an article through a mock API
  (`flutter_bloc`). The API fails ~20% of the time, so each card reflects a loading spinner,
  shows a success or error SnackBar, and lets you tap again to retry on failure.
- **Responsive layout** — content is centered and capped at 700px so text stays readable on
  large screens; the header stays aligned with the card column.
- **Light/dark mode** — a toggle in the app bar switches themes (in-memory; defaults to light).

## Project structure

```
lib/
├── models/        # Data models (Article, SaveResult)
├── data/          # Mock data and the ArticleApi abstraction (MockArticleApi)
├── controllers/   # BLoCs (ArticleBloc for saving, ThemeBloc for theming)
├── views/         # Screens and widgets (ArticleScreen, ArticleCard)
└── main.dart      # App entry point and theme setup
```

## Getting started

**Prerequisites:** the [Flutter SDK](https://docs.flutter.dev/get-started/install) with Dart
`^3.10.4` (see `pubspec.yaml`).

```bash
cd eco-test
flutter pub get
flutter run
```

To run in a browser:

```bash
flutter run -d chrome
```

Optional — analyze the code:

```bash
flutter analyze
```
