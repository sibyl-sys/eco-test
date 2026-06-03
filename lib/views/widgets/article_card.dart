import 'package:flutter/material.dart';
import '../../models/article_model.dart';

class ArticleCard extends StatelessWidget {
  final Article article;
  const ArticleCard({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(title: Text(article.title)),
    );
  }
}
