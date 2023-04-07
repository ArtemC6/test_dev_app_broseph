import '../models/article_model.dart';

abstract class ArticleState {}

class ArticleInitialState extends ArticleState {}

class ArticleLoadingState extends ArticleState {}

class ArticleLoadedState extends ArticleState {
  ArticleLoadedState({required this.loadedArticle});

  List<Article> loadedArticle;
}

class ArticleErrorState extends ArticleState {}
