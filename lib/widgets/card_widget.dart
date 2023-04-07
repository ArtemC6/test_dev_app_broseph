import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:test_dev_app_broseph/widgets/component_widget.dart';

import '../bloc/article_bloc.dart';
import '../bloc/article_event.dart';
import '../config/Utils/utils.dart';
import '../models/article_model.dart';
import '../screen/article_screen.dart';
import 'bloc_widget.dart';

class cardArticle extends StatefulWidget {
  const cardArticle({
    super.key,
    required this.listArticle,
    required this.index,
  });

  final List<Article> listArticle;
  final int index;

  @override
  State<cardArticle> createState() => _cardArticleState(listArticle, index);
}

class _cardArticleState extends State<cardArticle> {
  final List<Article> listArticle;
  final int index;

  _cardArticleState(this.listArticle, this.index);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final timeAnimation =
        widget.index + 1 * 450 < 1600 ? widget.index + 1 * 450 : 450;

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        FadeRouteAnimation(
          ArticleScreen(
            article: widget.listArticle,
            index: widget.index,
          ),
        ),
      ),
      child: Card(
        shadowColor: Colors.white38,
        color: black_86,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(
            width: 0.8,
            color: Colors.white24,
          ),
        ),
        elevation: 8,
        child: Container(
          decoration: const BoxDecoration(
              color: black_86,
              borderRadius: BorderRadius.all(Radius.circular(16))),
          margin: EdgeInsets.only(bottom: height / 98),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Stack(
                  children: [
                    CachedNetworkImage(
                        progressIndicatorBuilder: (context, url, progress) =>
                            Center(
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
                        imageUrl: widget.listArticle[widget.index].urlToImage,
                        fit: BoxFit.cover,
                        height: height * .28,
                        width: width),
                    Positioned(
                      bottom: 14,
                      right: 14,
                      child: InkWell(
                        onTap: () async {
                          final box = await Hive.box('articleData');
                          if (widget.listArticle[widget.index].isSave == true) {
                            await box.deleteAt(widget.index);
                            setState(() => widget
                                .listArticle[widget.index].isSave = false);
                          } else {
                            await box.add(widget.listArticle[widget.index]
                              ..isSave = true);
                            setState(() =>
                                widget.listArticle[widget.index].isSave = true);
                          }
                        },
                        child: Container(
                          margin: EdgeInsets.only(left: width / 42),
                          height: height / 15,
                          width: height / 15,
                          decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.50),
                              borderRadius: BorderRadius.circular(99)),
                          child: Icon(
                            widget.listArticle[widget.index].isSave
                                ? Icons.favorite_outlined
                                : Icons.favorite_outline,
                            color: Colors.blueAccent,
                            size: height / 30,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: height / 82, top: height / 92, bottom: height / 92),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    animatedText(
                        size: height / 64,
                        text: widget.listArticle[widget.index].title,
                        color: Colors.white,
                        time: timeAnimation - 100,
                        line: 2),
                    Container(
                      alignment: Alignment.centerRight,
                      padding:
                          EdgeInsets.only(top: width / 52, right: width / 42),
                      child: animatedText(
                          size: height / 82,
                          text: widget.listArticle[widget.index].author,
                          color: Colors.white,
                          time: timeAnimation,
                          line: 1),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class listCardTabArticle extends StatelessWidget {
  const listCardTabArticle({
    super.key,
    required TabController tabController,
    required ArticleBloc blocArticle,
    required this.controller,
    required TextEditingController textFieldSearch,
  })  : _tabController = tabController,
        _blocArticle = blocArticle,
        _textFieldSearch = textFieldSearch;

  final TabController _tabController;
  final ArticleBloc _blocArticle;
  final ScrollController controller;
  final TextEditingController _textFieldSearch;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TabBarView(
        controller: _tabController,
        children: [
          Tab(
            child: RefreshIndicator(
              child: listViewArticle(
                blocArticle: _blocArticle,
                controllerNavBar: controller,
              ),
              onRefresh: () async => _blocArticle.add(
                ArticleLoadAppleEvent(search: _textFieldSearch.text),
              ),
            ),
          ),
          Tab(
            child: RefreshIndicator(
              child: listViewArticle(
                blocArticle: _blocArticle,
                controllerNavBar: controller,
              ),
              onRefresh: () async => _blocArticle.add(
                ArticleLoadTeslaEvent(search: _textFieldSearch.text),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
