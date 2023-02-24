import 'package:cached_network_image/cached_network_image.dart';
import 'package:commons/commons.dart';
import 'package:finplus/finplus/screens/community/custom_drop_down/custom_drop_down.dart';
import 'package:finplus/finplus/screens/feed_detail/feed_detail_controller.dart';
import 'package:finplus/finplus/screens/home/home_controller.dart';
import 'package:finplus/providers/community_provider/models/feed_data.dart';
import 'package:finplus/routes/finplus_routes.dart';
import 'package:finplus/utils/styles.dart';
import 'package:finplus/widgets/avatar/avatar.dart';
import 'package:finplus/widgets/dialog/notification_dialog.dart';
import 'package:finplus/widgets/show_text_more/show_text_more.dart';
import 'package:flutter/material.dart';

import '../../../../providers/community_provider/community_provider.dart';

class FeedContainer extends StatelessWidget {
  final RxFeedData feedData;
  final VoidCallback? onDeletedPost;

  const FeedContainer({super.key, required this.feedData, this.onDeletedPost});
  @override
  Widget build(BuildContext context) {
    final HomeController h = Get.find();
    final theme = context.t;
    return Obx(() {
      {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: InkWell(
            onTap: () {
              Get.toNamed(Routes.feed_detail,
                  arguments: FeedDetailArgument(
                      feedData, postReactFeed, onDeletedPost));
            },
            child: Container(
              padding: Spaces.a10,
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                    offset: const Offset(2, 0),
                    blurRadius: 5,
                    color: theme.primary_01.withOpacity(0.5))
              ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 12, top: 12, right: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Avatar(value: feedData.userInfo.avatar),
                            Spaces.box12,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  feedData.userInfo.displayName,
                                  style: TextDefine.P4_B,
                                ),
                                Spaces.box4,
                                Text(
                                  Commons.getTimeDifferenceFromNow(
                                      feedData.createdAt),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        CustomDropdown<String>(
                            onTapItem: (p0, i) {
                              if (h.userInfo.value?.userInfo.id !=
                                      feedData.userInfo.id &&
                                  i == 0) {
                              } else if (i == 0) {
                              } else if (i == 1) {
                                Get.dialog(NotificationDialog(
                                    showCancelButton: true,
                                    cancelText: 'Hủy',
                                    confirmText: 'Xóa',
                                    title: 'Xóa bài viết',
                                    description:
                                        'Bạn chắc chắn muốn xóa bài viết này? Bạn sẽ không thể khôi phục bài viết sau khi xóa.',
                                    onCancelBtnPressed: Get.back,
                                    onConfirmBtnPressed: onDeletedPost));
                              }
                            },
                            itemBuilder: (String item, int i) => InkWell(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        if (h.userInfo.value?.userInfo.id !=
                                                feedData.userInfo.id &&
                                            i == 0)
                                          const Icon(Icons.report)
                                        else if (i == 0)
                                          const Icon(Icons.mode_edit_outlined)
                                        else if (i == 1)
                                          const Icon(
                                              Icons.delete_forever_rounded),
                                        const SizedBox(width: 4),
                                        Text(
                                          item,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                            items: h.userInfo.value?.userInfo.id !=
                                    feedData.userInfo.id
                                ? ['Báo cáo bài viết']
                                : [
                                    'Chỉnh sửa bài viết',
                                    'Xoá bài viết',
                                  ],
                            child: const Icon(Icons.more_horiz)),
                      ],
                    ),
                  ),
                  Spaces.box14,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Wrap(
                      spacing: 6.0,
                      runSpacing: 4.0,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color(0xffD9D9D9),
                          ),
                          child: const Padding(
                            padding: Spaces.h4v6,
                            child: Text(
                              'MBB',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 9,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color(0xffD9D9D9),
                          ),
                          child: const Padding(
                            padding: Spaces.h4v6,
                            child: Text(
                              'SHS',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 9,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color(0xffD9D9D9),
                          ),
                          child: const Padding(
                            padding: Spaces.h4v6,
                            child: Text(
                              'VIC',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 9,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Obx(
                    () => Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: ShowMoreText(
                        content: feedData.content,
                        showMoreLength: 100,
                        contentStyle: TextDefine.P2_R,
                      ),
                    ),
                  ),
                  Obx(() => feedData.attachment.isNotEmpty
                      ? SizedBox(
                          height: 100,
                          width: Get.width,
                          child: CachedNetworkImage(
                            imageUrl: feedData.attachment,
                            fit: BoxFit.cover,
                          ),
                        )
                      : const SizedBox()),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Wrap(
                          spacing: -6,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: const Placeholder(
                                fallbackHeight: 22,
                                fallbackWidth: 22,
                              ),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: const Placeholder(
                                fallbackHeight: 22,
                                fallbackWidth: 22,
                              ),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: const Placeholder(
                                fallbackHeight: 22,
                                fallbackWidth: 22,
                              ),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: const Icon(
                                Icons.more_horiz,
                                size: 22,
                              ),
                            ),
                          ],
                        ),
                        Obx(() => Row(
                              children: [
                                Text(
                                  '${feedData.likeCount} Like',
                                  style: TextDefine.P4_R
                                      .copyWith(color: const Color(0xff7A8599)),
                                ),
                                Spaces.box6,
                                Text(
                                  '${feedData.children.map((e) => e.type == FEED_TYPE.COMMENT).length} Comment',
                                  style: TextDefine.P4_R
                                      .copyWith(color: const Color(0xff7A8599)),
                                ),
                                Spaces.box6,
                              ],
                            ))
                      ],
                    ),
                  ),
                  const Divider(
                    indent: 12,
                    endIndent: 12,
                    height: 1,
                    thickness: 1,
                    color: Color(0xffD3DAE5),
                  ),
                  Spaces.box10,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: postReactFeed,
                          child: Row(
                            children: [
                              Obx(
                                () => Icon(
                                  Icons.heart_broken,
                                  color: feedData.reactList.userLike
                                          .where((element) =>
                                              element.userId ==
                                              h.userInfo.value?.userInfo.id)
                                          .isNotEmpty
                                      ? Colors.red
                                      : const Color(0xff4E5D78),
                                  size: 15,
                                ),
                              ),
                              Spaces.box4,
                              const Text(
                                'Like',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xff4E5D78),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: const [
                            Text(
                              'Comment',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff4E5D78),
                              ),
                            ),
                            Spaces.box4,
                            Icon(
                              Icons.add_comment,
                              color: Color(0xff4E5D78),
                              size: 15,
                            ),
                          ],
                        ),
                        Row(
                          children: const [
                            Text('Share',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xff4E5D78),
                                )),
                            Spaces.box4,
                            Icon(
                              Icons.share_sharp,
                              color: Color(0xff4E5D78),
                              size: 15,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }
    });
  }

  Future<void> postReactFeed() async {
    final HomeController h = Get.find();
    if (feedData.reactList.userLike
        .where((element) => element.userId == h.userInfo.value?.userInfo.id)
        .isEmpty) {
      feedData.update((val) {
        val?.reactList.userLike.add(UserLike(
            action: FEED_REACT.LIKE,
            feedId: feedData.id,
            userId: h.userInfo.value?.userInfo.id ?? -1));
      });
      feedData.update((val) {
        val?.likeCount++;
      });
      await CommunityProvider().postReactFeed(feedData.id, FEED_REACT.LIKE);
    } else {
      feedData.update((val) {
        val?.reactList.userLike.removeWhere(
            (element) => element.userId == h.userInfo.value?.userInfo.id);
      });
      feedData.update((val) {
        val?.likeCount--;
      });
      await CommunityProvider().postReactFeed(feedData.id, FEED_REACT.DISLIKE);
    }
  }
}
