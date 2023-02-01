import 'package:commons/commons.dart';
import 'package:finplus/finplus/screens/community/community.dart';
import 'package:flutter/material.dart';

import 'home_controller.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (c) {
      return const Scaffold(
        body: Community(),
      );
    });
  }
}
