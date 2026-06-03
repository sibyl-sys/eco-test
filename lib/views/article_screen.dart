import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../controllers/article_bloc.dart';
import '../controllers/theme_bloc.dart';
import '../data/api_service.dart';
import '../data/sample_data.dart';
import 'widgets/article_card.dart';

const double _maxContentWidth = 700;

class ArticleScreen extends StatelessWidget {
  const ArticleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    return BlocProvider(
      create: (_) => ArticleBloc(MockArticleApi()),
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
          surfaceTintColor: Colors.transparent,
          backgroundColor: WidgetStateColor.resolveWith(
            (states) {
              if (!states.contains(WidgetState.scrolledUnder)) {
                return colorScheme.surface;
              }
              return isDark
                  ? colorScheme.surfaceContainerHighest
                  : colorScheme.surfaceContainerLowest;
            },
          ),
          title: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: _maxContentWidth),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    const Expanded(child: Text('For You')),
                    IconButton(
                      tooltip:
                          isDark ? 'Switch to light mode' : 'Switch to dark mode',
                      icon: Icon(isDark
                          ? Icons.light_mode_outlined
                          : Icons.dark_mode_outlined),
                      onPressed: () => context
                          .read<ThemeBloc>()
                          .add(ThemeToggled(Theme.of(context).brightness)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: BlocListener<ArticleBloc, ArticleState>(
          listenWhen: (prev, curr) =>
              curr.feedback != null && curr.feedback != prev.feedback,
          listener: (context, state) {
            final feedback = state.feedback!;
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(
                content: Text(feedback.message),
                backgroundColor: feedback.isError
                    ? Theme.of(context).colorScheme.error
                    : null,
              ));
          },
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: _maxContentWidth),
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: mockArticles.length,
                itemBuilder: (context, index) {
                  return ArticleCard(article: mockArticles[index]);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
