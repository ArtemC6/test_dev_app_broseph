import '../models/article_model.dart';
import 'article_api_provider.dart';

class ArticleRepository {
  final articleProvider = ArticleProvider();

  Future<List<Article>> getAllArticles(
          String select, int pageSize, String search) =>
      articleProvider.getArticle(select, pageSize, search);
}
