import 'package:commons/commons.dart';
import 'package:finplus/finplus/screens/home/home_controller.dart';
import 'package:flutter/material.dart';

import '../../../utils/utils.dart';

class CreatePostController extends GetxController with HomeControllerMinxin {
  late final Rx<List<String>> images;

  late final RxBool enablePost;

  late final FocusNode focusNode;

  late final int groupId;

  late final List<String>? attachment;

  late final int? parentId;

  late final bool isCommentable;

  late final TextEditingController content;

  late final RxString name;

  @override
  void onInit() {
    enablePost = false.obs;
    images = Rx([]);
    focusNode = FocusNode();
    isCommentable = true;
    content = TextEditingController();
    groupId = 2;
    name = RxString('');
    super.onInit();
  }

  @override
  void onReady() {
    content.addListener(() {
      enablePost(content.text.trim().isNotEmpty);
    });
    super.onReady();
  }

  Future<void> pickImage() async {
    final List<String> imagesPath = await Utils.pickMultipleImages();
    if (imagesPath != null) {
      images.update((val) {
        val?.addAll(imagesPath);
      });
    }
  }

  @override
  void onClose() {
    focusNode.dispose();
    content.dispose();
    super.onClose();
  }
}
