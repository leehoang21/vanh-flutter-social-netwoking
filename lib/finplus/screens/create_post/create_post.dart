import 'dart:io';

import 'package:commons/commons.dart';
import 'package:finplus/finplus/screens/create_post/create_post_controller.dart';
import 'package:finplus/finplus/screens/images_view/images_view.dart';
import 'package:finplus/widgets/avatar/avatar.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

import '../../../routes/finplus_routes.dart';
import '../../../utils/styles.dart';
import '../../../utils/svg.dart';

class CreatePost extends StatelessWidget {
  CreatePost({super.key});
  final controller = Get.put(
    CreatePostController(),
  );

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreatePostController>(
      init: CreatePostController(),
      builder: (controller) {
        return Scaffold(
          extendBody: true,
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 9,
                        width: 48,
                        child: InkWell(
                          child: SvgPicture.asset(
                            SvgIcon.close,
                          ),
                          onTap: () => Get.back(),
                        ),
                      ),
                      const Text(
                        'Create a post',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Obx(
                        () {
                          return InkWell(
                            onTap: () => controller.enablePost.value
                                ? controller.createFeed()
                                : null,
                            child: Container(
                              height: 24,
                              width: 48,
                              padding: Spaces.h10v6,
                              decoration: BoxDecoration(
                                color: controller.enablePost.value
                                    ? const Color(0xFF17AB37)
                                    : Colors.white,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(3),
                                ),
                              ),
                              child: Text(
                                'Post',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: controller.enablePost.value
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 1,
                  color: const Color(0xFFD9D9D9),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: Spaces.h16v12,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 4,
                                  ),
                                  child: const Avatar(
                                    value: '',
                                    size: 38,
                                  )),
                              Spaces.box10,
                              const Text(
                                'Trần Thuỳ Linh',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          child: KeyboardActions(
                            disableScroll: true,
                            config: controller.buildConfig(context),
                            child: TextField(
                              controller: controller.postContentController,
                              scrollPhysics:
                                  const NeverScrollableScrollPhysics(),
                              keyboardType: TextInputType.text,
                              focusNode: controller.focusNode,
                              maxLines: null,
                              maxLength: 2000,
                              inputFormatters: const [],
                              decoration: const InputDecoration(
                                hintText:
                                    'Write something...\n@ to mention someone else',
                                fillColor: Colors.white,
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: Spaces.h16v12,
                          child: Obx(
                            () {
                              if (controller.images.value.isEmpty) {
                                return const SizedBox();
                              }
                              int length = controller.images.value.length;
                              if (length > 4) {
                                length = 4;
                              }
                              final int remaining =
                                  controller.images.value.length - 4;
                              final images =
                                  controller.images.value.getRange(0, length);

                              return Wrap(
                                runSpacing: 10,
                                spacing: 10,
                                alignment: WrapAlignment.start,
                                children: images
                                    .mapIndexed(
                                      (index, e) => InkWell(
                                        onTap: () {
                                          Get.toNamed(
                                            Routes.images_view,
                                            arguments: ImageViewArgument(
                                              listImages:
                                                  controller.images.value,
                                              index: index,
                                              imageType: IMAGE_TYPE.PATH,
                                            ),
                                          );
                                        },
                                        child: Stack(
                                          children: [
                                            Image.file(
                                              File(e),
                                              width: Get.width / 2 - 21,
                                              height: Get.width / 2 - 21,
                                              fit: BoxFit.cover,
                                            ),
                                            if (index == 3 && remaining > 0)
                                              Container(
                                                decoration: const BoxDecoration(
                                                  color: Colors.black38,
                                                ),
                                                alignment: Alignment.center,
                                                width: Get.width / 2 - 21,
                                                height: Get.width / 2 - 21,
                                                child: Text(
                                                  '+${remaining.toString()}',
                                                  style: const TextStyle(
                                                    fontSize: 24,
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              )
                                          ],
                                        ),
                                      ),
                                    )
                                    .toList(),
                              );
                              // return ImageBox(
                              //   images: controller.images.value,
                              //   image_type: IMAGE_TYPE.PATH,
                              // );
                            },
                          ),
                        ),
                        Spaces.box42,
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
