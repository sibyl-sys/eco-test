import 'package:flutter/material.dart';

// Add any state management imports here
// ── Data models ─────────────────────────────────────────────────────────
class Article {
  final String id;
  final String title;
  final String author;
  final String preview;
  const Article({
    required this.id,
    required this.title,
    required this.author,
    required this.preview,
  });
}

class SaveResult {
  final String articleId;
  final bool saved;
  const SaveResult({required this.articleId, required this.saved});
}

// ── Mock data ────────────────────────────────────────────────────────────
final List<Article> mockArticles = [
  Article(
    id: 'a1',
    title: 'Getting started with async Dart',
    author: 'Jane Smith',
    preview: 'Futures, streams, and why they matter...',
  ),
  Article(
    id: 'a2',
    title: 'Flutter performance tips for 2025',
    author: 'Tom Lee',
    preview: 'const widgets, RepaintBoundary, and more...',
  ),
  Article(
    id: 'a3',
    title: 'Designing APIs that last',
    author: 'Priya Rao',
    preview: 'Versioning, pagination, and error contracts...',
  ),
];
// ── Simulated API — do not modify ────────────────────────────────────────
// Succeeds ~80% of the time, fails ~20%.
Future<SaveResult> saveArticle(String articleId) async {
  await Future.delayed(const Duration(milliseconds: 800));
  if (DateTime.now().millisecondsSinceEpoch % 10 < 2) {
    throw Exception('Network error — please try again');
  }
  return SaveResult(articleId: articleId, saved: true);
}

// ── Your implementation ───────────────────────────────────────────────────
// TODO: Build ArticleCard and wire it into the list below.
// Use whatever state management approach you prefer.
void main() {
  // Add any required wrapper here (e.g. ProviderScope for Riverpod)
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Article Feed',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text('For You')),
        body: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: mockArticles.length,
          itemBuilder: (context, index) {
            // TODO: Replace with your ArticleCard widget
            return Card(
              child: ListTile(title: Text(mockArticles[index].title)),
            );
          },
        ),
      ),
    );
  }
}
