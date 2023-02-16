import 'package:commons/commons.dart';
import 'package:finplus/finplus/screens/home/home_controller.dart';
import 'package:flutter/material.dart';

import '../../../providers/community_provider/community_provider.dart';
import '../../../utils/utils.dart';

class CreatePostController extends GetxController with HomeControllerMinxin {
  late final CommunityProvider _communityProvider;

  late final Rx<List<String>> images;

  late final RxBool enablePost;

  late final FocusNode focusNode;

  late final int groupId;

  late final FEED_TYPE type;

  late final List<String>? attachment;

  late final int? parentId;

  late final bool isCommentable;

  late final TextEditingController content;

  @override
  void onInit() {
    _communityProvider = CommunityProvider();
    enablePost = false.obs;
    images = Rx([]);
    focusNode = FocusNode();
    isCommentable = true;
    content = TextEditingController();
    groupId = 2;
    type = FEED_TYPE.POST;
    super.onInit();
  }

  @override
  void onReady() {
    content.addListener(() {
      enablePost(content.text.trim().isNotEmpty);
    });
    super.onReady();
  }

  Future<void> createFeed() async {
    if (userInfo != null && enablePost.value) {
      final res = await _communityProvider.createFeed(
        groupId: groupId,
        content: content.text,
        type: type,
        userInfo: userInfo!.userInfo,
      );
      Get.back();
    }
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