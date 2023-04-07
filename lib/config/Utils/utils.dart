import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../screen/home_screen.dart';
import '../../screen/save_screen.dart';

const black_93 = Color(0xFF161616);
const black_86 = Color(0xFF222327);

class FadeRouteAnimation extends PageRouteBuilder {
  final Widget page;

  FadeRouteAnimation(this.page)
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: page,
          ),
        );
}

const List<BottomNavigationBarItem> bottomNavList = [
  BottomNavigationBarItem(
    icon: Icon(Icons.home, color: Colors.white),
    label: 'Home',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.bookmark_border),
    label: 'Save',
  ),
];

Future<void> openUrl(String uri) async {
  await launchUrl(Uri.parse(uri));
}

childEmployee(
    {required int currentIndex, required ScrollController controller}) {
  var child;
  if (currentIndex == 0) {
    child = HomeScreen(controller: controller);
  } else {
    child = SaveArticleScreen(
      controller: controller,
    );
  }
  return child;
}
