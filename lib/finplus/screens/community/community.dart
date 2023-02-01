import 'package:commons/commons.dart';
import 'package:finplus/finplus/screens/community/community_controller.dart';
import 'package:finplus/routes/finplus_routes.dart';
import 'package:finplus/widgets/button/button.dart';
import 'package:flutter/material.dart';

class Community extends StatelessWidget {
  const Community({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CommunityController>(builder: (c) {
      return Scaffold(
        appBar: AppBar(),
        body: Button(
          onPressed: () => Get.toNamed(Routes.chat_room),
          child: const Text('Chat room'),
        ),
      );
    });
  }
}
