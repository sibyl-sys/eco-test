import '../models/article_model.dart';

// ── Simulated API — do not modify ────────────────────────────────────────
// Succeeds ~80% of the time, fails ~20%.
Future<SaveResult> saveArticle(String articleId) async {
  await Future.delayed(const Duration(milliseconds: 800));
  if (DateTime.now().millisecondsSinceEpoch % 10 < 2) {
    throw Exception('Network error — please try again');
  }
  return SaveResult(articleId: articleId, saved: true);
}
