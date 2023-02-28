import 'package:commons/commons.dart';
import 'package:finplus/providers/community_provider/community_provider.dart';
import 'package:finplus/providers/community_provider/models/feed_data.dart';
import 'package:finplus/utils/get_arguments_mixin.dart';
import 'package:flutter/cupertino.dart';

import '../home/home_controller.dart';

class FeedDetailArgument {
  final num userId;
  final RxFeedData feedData;
  final void Function() postReactFeed;
  final VoidCallback? onDeletedPost;
  FeedDetailArgument(this.feedData, this.postReactFeed, this.onDeletedPost, this.userId);
}

class FeedDetailController extends GetxController
    with GetArguments<FeedDetailArgument>, HomeControllerMinxin {
  late final TextEditingController textComment;
  late final FocusNode focusNode;
  late final Rx<List<String>> images;
  late final CommunityProvider communityProvider;
  @override
  void onInit() {
    textComment = TextEditingController(text: '');
    focusNode = FocusNode();
    images = Rx([]);
    communityProvider = CommunityProvider();
    super.onInit();
  }

  Future<void> postComment() async {
    final result = await communityProvider.createFeed(
        groupId: 2,
        content: textComment.text,
        type: FEED_TYPE.COMMENT,
        userInfo: userInfo!.userInfo,
        parentId: arguments?.feedData.id);
    if (result?.id != null) {
      arguments?.feedData.update((val) {
        val?.children.add(FeedData(
            reactList: ReactData(userDislike: [], userLike: []),
            children: [],
            id: 0,
            createdAt: DateTime.now(),
            createdBy: userInfo!.userInfo.id,
            parentId: arguments?.feedData.id ?? 0,
            userInfo: userInfo!.userInfo,
            content: textComment.text));
      });
    }
    focusNode.unfocus();
    textComment.clear();
  }

  Future<void> deleteComment(num id) async {
    arguments?.feedData.update((val) {
      val?.children.removeWhere((element) {
        return element.id == id;
      });
    });
    Get.back();

    await communityProvider.deleteFeed(id);
  }
}
