import 'package:flutter/material.dart';
import '../data/sample_data.dart';
import 'widgets/article_card.dart';

class ArticleScreen extends StatelessWidget {
  const ArticleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('For You')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: mockArticles.length,
        itemBuilder: (context, index) {
          return ArticleCard(article: mockArticles[index]);
        },
      ),
    );
  }
}
