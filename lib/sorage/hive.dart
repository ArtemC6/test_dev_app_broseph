import 'package:hive/hive.dart';

import '../models/article_model.dart';

class HiveManager {
  static final userBox = Hive.box('articleData');

  static Future<List<Article>> getAllArticle() async {
    List<Article> listArticle = [];

    for (int i = 0; i < userBox.length; i++) {
      listArticle.add(userBox.getAt(i) as Article);
    }

    return listArticle;
  }
}
