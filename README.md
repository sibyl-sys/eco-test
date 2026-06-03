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

## Part II: API design

### Endpoint

**HTTP Method:** `PUT`

**Path:**

```http
PUT /users/{userId}/saved-articles/{articleId}
```

**Request Body:** None required.

**Response:**

For a newly saved article:

```http
201 Created
Location: /users/42/saved-articles/456
```

```json
{
  "userId": "42",
  "articleId": "456",
  "savedAt": "2026-06-03T10:00:00Z"
}
```

For an already saved article:

```http
200 OK
```

### Deduplication

- Use the idempotent `PUT` method.
- Saves are applied with a single conditional atomic update that only pushes the article when it isn't already present:

```js
db.users.updateOne(
  { _id: userId, "savedArticles.articleId": { $ne: articleId } },
  { $push: { savedArticles: { articleId, savedAt } } },
);
```

### Schema (NoSQL)

**articles collection**

```json
{
  "_id": "articleId",
  "title": "string",
  "author": "string",
  "publishedAt": "date",
  "preview": "string",
  "body": "string"
}
```

**users collection**

```json
{
  "_id": "userId",
  "email": "string",
  "passwordHash": "string",
  "savedArticles": [
    {
      "articleId": "articleId",
      "savedAt": "date"
    }
  ]
}
```

A NoSQL document model is suitable because saved articles are user-specific data that can be embedded within the user document for simple retrieval and updates.

### Edge Case

If the article has been deleted before the save request is processed:

```http
404 Not Found
```

```json
{
  "error": "Article not found or no longer available"
}
```

No saved article record should be created.

## Part III: Your Thinking

- _What state management approach did you use, and why? What would you choose
  for a large existing codebase vs. a greenfield project?_
  - I used bloc pattern for maintainability, readability and testability. Normally without AI, with smaller projects like this, it is acceptable to use Riverpod or Provider but with the emerging technology of tools like coding agents, the learning curve of BLoC becomes more shallow. Given this, both large existing codebase and a greenfield project should use bloc for maintainability and testability.
- _What assumptions did you make that you'd normally clarify with the team first?_
  - I would usually clarify with the designs first as those are important but I had to assume a minimalist design as the UI/UX requirements were not provided. I also assumed that refactoring is allowed to improve code readability and maintainability.
- _What did you cut from your implementation, and why?_
  - I believe I was actually able to implement all of the requirements as I was allowed to use AI normally. The use of this emerging agentic allows for more planning and less coding. I was even able to squeeze in adaptive views and dark mode.
- _What would you add or change with another hour?_
  - I would probably add the ability to unsave an article if given another hour.
