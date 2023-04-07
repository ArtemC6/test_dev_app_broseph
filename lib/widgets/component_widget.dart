import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_loading/card_loading.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';

import '../config/Utils/utils.dart';
import '../models/article_model.dart';
import 'card_widget.dart';

class loadingArticle extends StatelessWidget {
  const loadingArticle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.only(bottom: size.height / 26),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CardLoading(
            cardLoadingTheme: CardLoadingTheme(
                colorOne: Colors.white.withOpacity(.20), colorTwo: black_86),
            height: size.height * .22,
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            width: size.width,
            margin: const EdgeInsets.only(bottom: 10),
          ),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: CardLoading(
                  cardLoadingTheme: CardLoadingTheme(
                      colorOne: Colors.white.withOpacity(.20),
                      colorTwo: black_86),
                  height: 26,
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  margin: const EdgeInsets.only(bottom: 10),
                ),
              ),
              const Expanded(child: SizedBox()),
              Expanded(
                flex: 2,
                child: CardLoading(
                  cardLoadingTheme: CardLoadingTheme(
                      colorOne: Colors.white.withOpacity(.20),
                      colorTwo: black_86),
                  height: 30,
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  margin: const EdgeInsets.only(bottom: 10),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class animatedText extends StatelessWidget {
  const animatedText({
    super.key,
    required this.size,
    required this.text,
    required this.color,
    required this.time,
    required this.line,
  });

  final double size;
  final String text;
  final Color color;
  final int time, line;

  @override
  Widget build(BuildContext context) {
    return DelayedDisplay(
      delay: Duration(milliseconds: time),
      child: Text(
        overflow: TextOverflow.ellipsis,
        maxLines: line,
        text,
        style: GoogleFonts.lato(
          textStyle: TextStyle(color: color, fontSize: size, letterSpacing: .6),
        ),
      ),
    );
  }
}

class tabPanel extends StatelessWidget {
  const tabPanel({
    super.key,
    required this.tabController,
  });

  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.all(height / 72),
      child: TabBar(
        overlayColor: MaterialStateProperty.all(Colors.transparent),
        controller: tabController,
        indicator: BoxDecoration(
          border: Border.all(width: 0.7, color: Colors.blueAccent),
          borderRadius: BorderRadius.circular(
            16,
          ),
          color: Colors.white10,
        ),
        labelColor: Colors.white,
        unselectedLabelColor: Colors.blueAccent,
        tabs: [
          Tab(
            height: height / 22,
            child: animatedText(
                text: 'Apple',
                size: height / 62,
                color: Colors.white,
                time: 450,
                line: 1),
          ),
          Tab(
            height: height / 22,
            child: animatedText(
                text: 'Tesla',
                size: height / 62,
                color: Colors.white,
                time: 550,
                line: 1),
          ),
        ],
      ),
    );
  }
}

class imageArticle extends StatelessWidget {
  const imageArticle({
    super.key,
    required this.imageUrl,
  });

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height * .28,
      child: CachedNetworkImage(
          progressIndicatorBuilder: (context, url, progress) => Center(
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
          imageUrl: imageUrl,
          fit: BoxFit.cover,
          height: size.height * .30,
          width: MediaQuery.of(context).size.width),
    );
  }
}

class listArticle extends StatelessWidget {
  listArticle({
    super.key,
    required this.list,
    required this.controller,
    required this.isLocalData,
  });

  final List<Article> list;
  final ScrollController controller;
  final bool isLocalData;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height,
      child: AnimationLimiter(
        child: ListView.builder(
          controller: controller,
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.only(
              right: size.width / 26,
              left: size.width / 26,
              bottom: size.height / 20,
              top: size.height / 98),
          itemCount: list.length + 1,
          itemBuilder: (context, index) {
            if (index < list.length) {
              return AnimationConfiguration.staggeredList(
                position: index,
                delay: const Duration(milliseconds: 350),
                child: SlideAnimation(
                  duration: const Duration(milliseconds: 2200),
                  verticalOffset: 140,
                  child: FadeInAnimation(
                    duration: const Duration(milliseconds: 2500),
                    child: Padding(
                      padding: EdgeInsets.only(bottom: size.height / 42),
                      child: cardArticle(index: index, listArticle: list),
                    ),
                  ),
                ),
              );
            } else {
              if (list.length >= 1) {
                if (!isLocalData) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: size.height / 30),
                    child: const Center(
                      child: SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 0.8,
                        ),
                      ),
                    ),
                  );
                }
              }
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}

class fromTest extends StatelessWidget {
  const fromTest({
    super.key,
    required this.text,
    required this.time,
  });

  final String text;
  final int time;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.all(size.width / 36),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(
            width: 0.9,
            color: Colors.white24,
          ),
        ),
        elevation: 14,
        color: Colors.white.withOpacity(0.09),
        child: Padding(
          padding: EdgeInsets.all(size.width / 28),
          child: animatedText(
            size: size.height / 60,
            text: text,
            color: Colors.white,
            time: time,
            line: 12,
          ),
        ),
      ),
    );
  }
}

class searchPanel extends StatelessWidget {
  const searchPanel({super.key, required TextEditingController textFieldSearch})
      : _textFieldSearch = textFieldSearch;

  final TextEditingController _textFieldSearch;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Container(
      padding: EdgeInsets.all(height / 92),
      height: height / 13,
      decoration: const BoxDecoration(
        color: black_86,
        borderRadius: BorderRadius.all(Radius.circular(22)),
      ),
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: TextField(
          keyboardType: TextInputType.datetime,
          controller: _textFieldSearch,
          style: TextStyle(fontSize: height / 60, color: Colors.white),
          decoration: InputDecoration(
            fillColor: black_93,
            hintText: 'Search...',
            contentPadding: EdgeInsets.only(left: 20.0, bottom: 2.0, top: 2.0),
            hintStyle: TextStyle(color: Colors.white),
            suffixIcon: Padding(
              padding: EdgeInsets.only(right: height / 78),
              child: IconButton(
                onPressed: () async => await showDatePicker(
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2022),
                  lastDate: DateTime.now(),
                  context: context,
                ).then((date) {
                  if (date == null) return;
                  _textFieldSearch.text = date.toString().substring(0, 10);
                }),
                color: Colors.white,
                icon: const Icon(Icons.calendar_month),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(22),
              ),
              borderSide: BorderSide(width: 1, color: Colors.white),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(22),
              ),
              borderSide: BorderSide(
                width: 1,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
