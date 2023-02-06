import 'dart:io';

import 'package:commons/commons.dart';
import 'package:flutter/material.dart';

import '../../../utils/styles.dart';
import '../../../utils/svg.dart';
import 'create_post_controller.dart';

class PreviewImagesPost extends StatelessWidget {
  const PreviewImagesPost({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(
      CreatePostController(),
    );

    return Scaffold(
      extendBody: true,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: Spaces.h16v12,
                child: SizedBox(
                  height: 9,
                  width: 48,
                  child: InkWell(
                    child: SvgPicture.asset(
                      SvgIcon.close,
                    ),
                    onTap: () => Get.back(),
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ...controller.images.value
                          .mapIndexed(
                            (index, e) => Padding(
                              padding: Spaces.h12v16,
                              child: Image.file(
                                File(e),
                                width: Get.width - 56,
                                height: Get.width - 56,
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                          .toList(),
                    ],
                  ),
                ),
              ),
              Spaces.box24,
            ],
          ),
        ),
      ),
    );
  }
}
