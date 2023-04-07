abstract class ArticleEvent {}

class ArticleLoadAppleEvent extends ArticleEvent {
  final int? pageSize;
  final String? search;

  ArticleLoadAppleEvent({this.search, this.pageSize});
}

class ArticleLoadTeslaEvent extends ArticleEvent {
  final int? pageSize;
  final String? search;

  ArticleLoadTeslaEvent({this.search, this.pageSize});
}
