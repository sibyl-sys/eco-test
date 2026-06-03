import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/api_service.dart';

enum SaveStatus { initial, saving, success, failure }

class SaveFeedback {
  final String message;
  final bool isError;
  const SaveFeedback(this.message, {this.isError = false});
}

sealed class ArticleEvent {}

class ArticleSaveRequested extends ArticleEvent {
  final String articleId;
  ArticleSaveRequested(this.articleId);
}

class ArticleState {
  final Map<String, SaveStatus> statuses;
  final SaveFeedback? feedback;

  const ArticleState({this.statuses = const {}, this.feedback});

  SaveStatus statusOf(String articleId) =>
      statuses[articleId] ?? SaveStatus.initial;
}

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  final ArticleApi _api;

  ArticleBloc(this._api) : super(const ArticleState()) {
    on<ArticleSaveRequested>(_onSaveRequested);
  }

  Future<void> _onSaveRequested(
    ArticleSaveRequested event,
    Emitter<ArticleState> emit,
  ) async {
    emit(_withStatus(event.articleId, SaveStatus.saving));
    try {
      final result = await _api.saveArticle(event.articleId);
      if (result.saved) {
        emit(_withStatus(event.articleId, SaveStatus.success,
            feedback: const SaveFeedback('Article saved')));
      } else {
        emit(_withStatus(event.articleId, SaveStatus.failure,
            feedback: const SaveFeedback('Could not save', isError: true)));
      }
    } on Exception catch (e) {
      emit(_withStatus(event.articleId, SaveStatus.failure,
          feedback: SaveFeedback(
            e.toString().replaceFirst('Exception: ', ''),
            isError: true,
          )));
    }
  }

  ArticleState _withStatus(String id, SaveStatus status, {SaveFeedback? feedback}) {
    final next = Map<String, SaveStatus>.from(state.statuses)..[id] = status;
    return ArticleState(statuses: next, feedback: feedback);
  }
}
