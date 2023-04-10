import 'package:dio/dio.dart';

import '../models/article_model.dart';

class ArticleProvider {
  Future<List<Article>> getArticle(
      String select, int pageSize, String search) async {
    final key = '839e86a5df4448629660f243b1030c7b';

    if (search.isEmpty) search = '2023-03-10';

    final response = await Dio().get(
        'https://newsapi.org/v2/everything?q=$select&from=$search&pageSize=$pageSize&apiKey=$key');

    if (response.statusCode == 200) {
      List<Article> articles = [];
      response.data['articles'].forEach(
        (articleMap) => articles.add(Article.fromJson(articleMap)),
      );

      return articles;
    } else {
      throw Exception('Error');
    }
  }
}
