import 'package:flutter_bloc/flutter_bloc.dart';

import '../services/article_repository.dart';
import 'article_event.dart';
import 'article_state.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  late final ArticleRepository articleRepository;

  ArticleBloc({required this.articleRepository})
      : super(ArticleInitialState()) {
    on<ArticleLoadAppleEvent>(
      (event, emit) async {
        emit(ArticleLoadingState());
        try {
          final loadedArticleList = await articleRepository.getAllArticles(
              'apple', event.pageSize ?? 15, event.search ?? '');
          emit(ArticleLoadedState(loadedArticle: loadedArticleList));
        } catch (_) {
          emit(ArticleErrorState());
        }
      },
    );
    on<ArticleLoadTeslaEvent>(
      (event, emit) async {
        emit(ArticleLoadingState());
        try {
          final loadedArticleList = await articleRepository.getAllArticles(
              'tesla', event.pageSize ?? 15, event.search ?? '');
          emit(ArticleLoadedState(loadedArticle: loadedArticleList));
        } catch (_) {
          emit(ArticleErrorState());
        }
      },
    );
  }
}
