import 'dart:io';

import 'package:commons/commons.dart';
import 'package:finplus/finplus/screens/create_post/create_post_controller.dart';
import 'package:finplus/finplus/screens/home/home_controller.dart';
import 'package:finplus/finplus/screens/images_view/images_view.dart';
import 'package:finplus/widgets/avatar/avatar.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

import '../../../routes/finplus_routes.dart';
import '../../../utils/styles.dart';
import '../../../utils/svg.dart';
import '../../../utils/utils.dart';

class CreatePost extends StatelessWidget {
  const CreatePost({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController h = Get.find();
    final theme = context.t;
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
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        child: SvgPicture.asset(
                          SvgIcon.close,
                          height: 15,
                          color: theme.primary_01,
                        ),
                        onTap: Get.back,
                      ),
                      Text('Create a post',
                          style: TextDefine.T1_M
                              .copyWith(color: theme.primary_01)),
                      SizedBox(
                        width: 48,
                        child: Obx(
                          () {
                            return TextButton(
                              onPressed: controller.createFeed,
                              child: const Text(
                                'Post',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                              style: TextButton.styleFrom(
                                backgroundColor: controller.enablePost.value
                                    ? const Color(0xFF17AB37)
                                    : Colors.grey.withOpacity(0.5),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(
                  height: 0,
                  thickness: 1,
                  color: Color(0xFFD9D9D9),
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
                                child: Avatar(
                                    value: h.userInfo.value?.userInfo.avatar ??
                                        ''),
                              ),
                              Spaces.box10,
                              Obx(
                                () => Text(
                                  h.userInfo.value?.userInfo.displayName ?? '',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              )
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
                            config: Utils.buildKeyBoardConfig(
                                context,
                                controller.focusNode,
                                (images) {},
                                controller.createFeed),
                            child: TextField(
                              controller: controller.content,
                              scrollPhysics:
                                  const NeverScrollableScrollPhysics(),
                              keyboardType: TextInputType.text,
                              focusNode: controller.focusNode,
                              maxLines: null,
                              maxLength: 2000,
                              inputFormatters: const [],
                              decoration: const InputDecoration(
                                hintText: 'Bạn đang nghĩ gì?',
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
                                              images: controller.images.value,
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
