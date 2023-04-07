import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../config/Utils/utils.dart';
import '../models/article_model.dart';
import '../screen/article_screen.dart';
import 'component_widget.dart';

class interestingArticle extends StatelessWidget {
  List<Article> listArticle = [];

  interestingArticle(this.listArticle, {super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return SizedBox(
      height: height / 3,
      child: AnimationLimiter(
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          padding:
              const EdgeInsets.only(left: 6, bottom: 10, top: 24, right: 10),
          scrollDirection: Axis.horizontal,
          itemCount: listArticle.length,
          itemBuilder: (context, index) {
            int timeAnimation = index + 1 * 450 < 1600 ? index + 1 * 450 : 450;
            return AnimationConfiguration.staggeredList(
              position: index,
              delay: const Duration(milliseconds: 500),
              child: SlideAnimation(
                duration: const Duration(milliseconds: 2200),
                horizontalOffset: 140,
                child: FadeInAnimation(
                  duration: const Duration(milliseconds: 2500),
                  child: GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      FadeRouteAnimation(
                        ArticleScreen(
                          article: listArticle,
                          index: index,
                        ),
                      ),
                    ),
                    child: Container(
                      width: width * 0.40,
                      margin: const EdgeInsets.only(left: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                              side: const BorderSide(
                                width: 0.9,
                                color: Colors.white24,
                              ),
                            ),
                            elevation: 16,
                            color: Colors.white.withOpacity(0.09),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: CachedNetworkImage(
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
                                  imageUrl: listArticle[index].urlToImage,
                                  fit: BoxFit.fill,
                                  width: MediaQuery.of(context).size.width,
                                  height: height / 9),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: height / 120),
                              child: animatedText(
                                size: height / 78,
                                text: listArticle[index].title,
                                color: Colors.white,
                                time: timeAnimation,
                                line: 1,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
