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
