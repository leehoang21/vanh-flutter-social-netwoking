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
  late final TextEditingController postContentController;

  @override
  void onInit() {
    _communityProvider = CommunityProvider();
    enablePost = false.obs;
    images = Rx([]);
    focusNode = FocusNode();
    isCommentable = true;
    postContentController = TextEditingController();
    groupId = 2;
    type = FEED_TYPE.POST;
    super.onInit();
  }

  @override
  void onReady() {
    postContentController.addListener(() {
      enablePost(postContentController.text.trim().isNotEmpty);
    });
    super.onReady();
  }

  void onSubmit() {
    if (enablePost.value) {
      createFeed();
      Get.back();
    }
  }

  Future<void> createFeed() async {
    if (userInfo != null) {
      final res = await _communityProvider.createFeed(
        groupId: groupId,
        content: postContentController.text,
        type: type,
        userInfo: userInfo!.userInfo,
      );
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
    postContentController.dispose();
    super.onClose();
  }
}
