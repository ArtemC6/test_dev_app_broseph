import 'package:flutter/material.dart';

import '../bloc/article_bloc.dart';
import '../bloc/article_event.dart';
import '../services/article_repository.dart';
import '../widgets/card_widget.dart';
import '../widgets/component_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.controller}) : super(key: key);

  final ScrollController controller;

  @override
  State<HomeScreen> createState() => _HomeScreen(controller);
}

class _HomeScreen extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final _textFieldSearch = TextEditingController();
  late final TabController _tabController;
  final _blocArticle = ArticleBloc(articleRepository: ArticleRepository());
  int _pageSize = 15;

  final ScrollController controller;

  _HomeScreen(this.controller);

  @override
  void initState() {
    setController();
    super.initState();
  }

  void setController() {
    _blocArticle.add(ArticleLoadAppleEvent());
    _tabController = TabController(length: 2, vsync: this);

    _tabController.addListener(() {
      if (_tabController.index == 0) {
        _blocArticle.add(ArticleLoadAppleEvent());
      } else {
        _blocArticle.add(ArticleLoadTeslaEvent());
      }
    });

    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.offset) {
        if (_tabController.index == 0) {
          _blocArticle.add(ArticleLoadAppleEvent(
              pageSize: _pageSize += 15, search: _textFieldSearch.text));
        } else {
          _blocArticle.add(ArticleLoadTeslaEvent(
              pageSize: _pageSize += 15, search: _textFieldSearch.text));
        }
      }
    });

    _textFieldSearch.addListener(() {
      if (_textFieldSearch.text.length > 8) {
        if (_tabController.index == 0) {
          _blocArticle.add(ArticleLoadAppleEvent(
              search: _textFieldSearch.text, pageSize: 100));
        } else {
          _blocArticle.add(ArticleLoadTeslaEvent(
              search: _textFieldSearch.text, pageSize: 100));
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          body: Column(
            children: [
              searchPanel(textFieldSearch: _textFieldSearch),
              tabPanel(
                tabController: _tabController,
              ),
              listCardTabArticle(
                  tabController: _tabController,
                  blocArticle: _blocArticle,
                  controller: controller,
                  textFieldSearch: _textFieldSearch),
            ],
          ),
        ),
      ),
    );
  }
}
