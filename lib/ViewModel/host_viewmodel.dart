import 'dart:io';

import 'package:flutter/material.dart';
import 'package:karaoke/Views/nav_page/settings_page.dart';

import '../Views/nav_page/favourite_page.dart';
import '../Views/nav_page/home_page.dart';

class HostViewModel with ChangeNotifier {
  int currentIndex = 0;
  final PageController pageController = PageController();
  List<Widget> pages = [
    const HomePage(),
    const Favourite(),
    const SettingPage()
  ];
  late BuildContext context;

  void setContext(BuildContext contexts) {
    context = contexts;
    notifyListeners();
  }

  void onTabTap(int index) {
    pageController.jumpToPage(index);
  }

  void onPageChange(int index) {
    currentIndex = index;
    notifyListeners();
  }

  bool onTabTapBool(int index) {
    pageController.jumpToPage(0);
    notifyListeners();
    return false;
  }

  Future<bool> onWillPop() async {
    return currentIndex == 0
        ? (await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Are you sure?'),
              content: const Text('Do you want to exit an App'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('No'),
                ),
                TextButton(
                  onPressed: () => exit(0),
                  child: const Text('Yes'),
                ),
              ],
            ),
          ))
        : onTabTapBool(currentIndex);
  }
}
