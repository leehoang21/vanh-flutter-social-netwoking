import 'package:commons/commons.dart';
import 'package:flutter/material.dart';

class HomeController extends GetxController {
  late final PageController menuController, pageController;
  final int _currentPage = 10000;
  int _nextPage = 10000;

  @override
  void onInit() {
    menuController =
        PageController(viewportFraction: 0.2, initialPage: _currentPage);
    pageController = PageController(
        viewportFraction: 1, keepPage: false, initialPage: _currentPage);
    super.onInit();
  }

  @override
  void onReady() {
    pageController.addListener(() {
      if (pageController.page != null) {
        if (pageController.page != null) {
          _nextPage = pageController.page!.ceil();
          print(_nextPage);

          // if (_currentPage != _nextPage) {
          //   menuController.animateToPage(_nextPage,
          //       duration: const Duration(milliseconds: 200),
          //       curve: Curves.ease);
          //   _currentPage = _nextPage;
          // }
        }
      }
    });
    super.onReady();
  }

  @override
  void onClose() {
    menuController.dispose();
    pageController.dispose();
    super.onClose();
  }
}
