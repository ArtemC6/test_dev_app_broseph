import 'package:flutter/material.dart';

import '../config/Utils/utils.dart';
import '../models/article_model.dart';
import '../sorage/hive.dart';
import '../widgets/component_widget.dart';

class SaveArticleScreen extends StatefulWidget {
  const SaveArticleScreen({Key? key, required this.controller})
      : super(key: key);

  final ScrollController controller;

  @override
  State<SaveArticleScreen> createState() => _SaveArticleScreenState(controller);
}

class _SaveArticleScreenState extends State<SaveArticleScreen> {
  final ScrollController controller;

  _SaveArticleScreenState(this.controller);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Save Article'),
      ),
      backgroundColor: black_86,
      body: FutureBuilder<List<Article>>(
        future: HiveManager.getAllArticle(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return listArticle(
              list: snapshot.data!,
              controller: controller,
              isLocalData: true,
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
