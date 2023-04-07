import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:hive/hive.dart';

import '../config/Utils/utils.dart';
import '../models/article_model.dart';
import '../widgets/component_widget.dart';
import '../widgets/interesting_article.dart';

class ArticleScreen extends StatefulWidget {
  final List<Article> article;
  final int index;

  const ArticleScreen({Key? key, required this.article, required this.index})
      : super(key: key);

  @override
  _ArticleArticleScreen createState() => _ArticleArticleScreen(article, index);
}

class _ArticleArticleScreen extends State<ArticleScreen> {
  final List<Article> article;
  final int index;

  _ArticleArticleScreen(this.article, this.index);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          child: AnimationLimiter(
            child: AnimationConfiguration.staggeredList(
              position: 1,
              delay: const Duration(milliseconds: 200),
              child: SlideAnimation(
                duration: const Duration(milliseconds: 2000),
                horizontalOffset: 250,
                child: FadeInAnimation(
                  duration: const Duration(milliseconds: 2200),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          CachedNetworkImage(
                            progressIndicatorBuilder:
                                (context, url, progress) => Center(
                              child: SizedBox(
                                height: 30,
                                width: 30,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 0.8,
                                  value: progress.progress,
                                ),
                              ),
                            ),
                            imageUrl: article[index].urlToImage,
                            fit: BoxFit.cover,
                            height: size.height * .33,
                          ),
                          Positioned(
                            bottom: 24,
                            right: 20,
                            child: InkWell(
                              onTap: () async {
                                final box = await Hive.box('articleData');
                                if (article[widget.index].isSave == true) {
                                  await box.deleteAt(widget.index);
                                  setState(() => widget
                                      .article[widget.index].isSave = false);
                                } else {
                                  await box.add(
                                      article[widget.index]..isSave = true);
                                  setState(() => widget
                                      .article[widget.index].isSave = true);
                                }
                              },
                              child: Container(
                                margin: EdgeInsets.only(left: size.width / 42),
                                height: size.height / 15,
                                width: size.height / 15,
                                decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.50),
                                    borderRadius: BorderRadius.circular(99)),
                                child: Icon(
                                  article[index].isSave
                                      ? Icons.favorite_outlined
                                      : Icons.favorite_outline,
                                  color: Colors.blueAccent,
                                  size: size.height / 30,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.all(size.height / 38),
                        child: animatedText(
                            size: size.height / 50,
                            text: article[index].title,
                            color: Colors.white,
                            time: 650,
                            line: 3),
                      ),
                      fromTest(
                        text: article[index].description,
                        time: 750,
                      ),
                      fromTest(
                        text: article[index].content,
                        time: 850,
                      ),
                      GestureDetector(
                        onTap: () => openUrl(article[index].url),
                        child: fromTest(
                          text: article[index].url,
                          time: 950,
                        ),
                      ),
                      interestingArticle(article),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
