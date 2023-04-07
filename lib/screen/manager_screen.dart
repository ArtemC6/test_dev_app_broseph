import 'package:flutter/material.dart';
import 'package:scroll_bottom_navigation_bar/scroll_bottom_navigation_bar.dart';

import '../config/Utils/utils.dart';

class ManagerScreen extends StatefulWidget {
  const ManagerScreen({
    super.key,
  });

  @override
  _ManagerScreen createState() => _ManagerScreen();
}

class _ManagerScreen extends State<ManagerScreen> {
  final _controller = ScrollController();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    _controller.bottomNavigationBar.height = width / 4.2;
    _controller.bottomNavigationBar.tabNotifier.addListener(() => setState(() =>
        _currentIndex = _controller.bottomNavigationBar.tabNotifier.value));

    return Scaffold(
      bottomNavigationBar: ScrollBottomNavigationBar(
        unselectedItemColor: Colors.white,
        iconSize: 28,
        backgroundColor: black_86,
        controller: _controller,
        items: bottomNavList,
      ),
      body: SafeArea(
        top: false,
        child: SizedBox.expand(
          child: childEmployee(
            currentIndex: _currentIndex,
            controller: _controller,
          ),
        ),
      ),
    );
  }
}
