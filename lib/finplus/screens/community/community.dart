import 'package:commons/commons.dart';
import 'package:finplus/finplus/screens/community/community_controller.dart';
import 'package:finplus/utils/app_logger.dart';
import 'package:flutter/material.dart';

class Community extends StatelessWidget {
  const Community({super.key});

  @override
  Widget build(BuildContext context) {
    logD('message');
    return GetBuilder<CommunityController>(builder: (c) {
      return Container();
    });
  }
}
