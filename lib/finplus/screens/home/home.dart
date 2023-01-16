import 'package:commons/commons.dart';
import 'package:flutter/material.dart';

import 'home_controller.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (c) {
      return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () =>
                    Get.to(() => LogConsole(showCloseButton: true)),
                icon: const Icon(Icons.adb))
          ],
        ),
        body: PageView.builder(
          controller: c.pageController,
          itemBuilder: (_, i) => Text(
            i.toString(),
          ),
        ),
        bottomNavigationBar: Container(
          color: Colors.white,
          child: SafeArea(
            child: SizedBox(
              height: kBottomNavigationBarHeight,
              child: PageView.builder(
                physics: const NeverScrollableScrollPhysics(),
                controller: c.menuController,
                itemBuilder: (ctx, i) => InkWell(
                  onTap: () {
                    c.menuController.animateToPage(
                      i,
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeInOut,
                    );
                    c.pageController.animateToPage(
                      i,
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: Center(
                    child: Text(i.toString()),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
