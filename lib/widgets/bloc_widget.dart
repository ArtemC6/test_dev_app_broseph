import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/article_bloc.dart';
import '../bloc/article_state.dart';
import '../models/article_model.dart';
import '../sorage/hive.dart';
import 'component_widget.dart';

class listViewArticle extends StatelessWidget {
  const listViewArticle({
    super.key,
    required ArticleBloc blocArticle,
    required this.controllerNavBar,
  }) : _blocArticle = blocArticle;

  final ArticleBloc _blocArticle;
  final ScrollController controllerNavBar;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocBuilder<ArticleBloc, ArticleState>(
      bloc: _blocArticle,
      builder: (context, state) {
        if (state is ArticleLoadingState) {
          return CustomScrollView(
            slivers: [
              SliverPadding(
                padding: EdgeInsets.all(size.width * 0.035),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => loadingArticle(),
                    childCount: 12,
                  ),
                ),
              ),
            ],
          );
        }
        if (state is ArticleLoadedState) {
          return FutureBuilder<List<Article>>(
            future: HiveManager.getAllArticle(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!.length > 0) {
                  for (var i = 0; i < snapshot.data!.length; i++) {
                    if (snapshot.data![i].title ==
                        state.loadedArticle[i].title) {
                      state.loadedArticle[i].isSave = true;
                    }
                  }
                }

                return listArticle(
                  list: state.loadedArticle,
                  controller: controllerNavBar,
                  isLocalData: false,
                );
              } else {
                return SizedBox();
              }
            },
          );
        }

        if (state is ArticleErrorState) {
          return Center(
            child: animatedText(
              size: size.width * 0.045,
              text: 'Error',
              color: Colors.white,
              time: 400,
              line: 1,
            ),
          );
        }
        return SizedBox();
      },
    );
  }
}
