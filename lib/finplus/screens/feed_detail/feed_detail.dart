import 'package:commons/commons.dart';
import 'package:finplus/finplus/screens/community/new_feed/feed_container.dart';
import 'package:finplus/finplus/screens/feed_detail/feed_detail_controller.dart';
import 'package:finplus/finplus/screens/home/home_controller.dart';
import 'package:finplus/utils/styles.dart';
import 'package:finplus/widgets/dialog/notification_dialog.dart';
import 'package:flutter/material.dart';

import '../../../providers/community_provider/models/feed_data.dart';
import '../../../widgets/avatar/avatar.dart';
import '../../../widgets/show_text_more/show_text_more.dart';
import '../community/custom_drop_down/custom_drop_down.dart';

class FeedDetail extends StatelessWidget {
  const FeedDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController h = Get.find();
    final theme = context.t;
    return GetBuilder<FeedDetailController>(builder: (c) {
      return Scaffold(
          appBar: AppBar(backgroundColor: theme.secondary_01),
          body: Column(
            children: [
              Expanded(
                child: CustomScrollView(
                  slivers: [
                    if (c.arguments?.feedData != null)
                      SliverToBoxAdapter(
                          child: FeedContainer(
                        feedData: c.arguments!.feedData,
                        onDeletedPost: c.arguments?.onDeletedPost,
                      )),
                    Obx(() => c.arguments?.feedData != null
                        ? SliverList(
                            delegate: SliverChildBuilderDelegate(
                              childCount: c.arguments?.feedData.children
                                  .map((e) => e.type == FEED_TYPE.COMMENT)
                                  .length,
                              (context, index) {
                                final dataComment =
                                    c.arguments?.feedData.children[index];
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      left: 12, right: 12, top: 10),
                                  child: Row(
                                    children: [
                                      Avatar(
                                          value: dataComment?.userInfo.avatar ??
                                              ''),
                                      Spaces.box8,
                                      Expanded(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: Get.width,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Colors.grey
                                                    .withOpacity(0.1),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 12,
                                                  vertical: 8,
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(dataComment
                                                            ?.userInfo.name ??
                                                        ''),
                                                    ShowMoreText(
                                                        content: dataComment
                                                                ?.content ??
                                                            '')
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Spaces.box4,
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  Commons
                                                      .getTimeDifferenceFromNow(
                                                          dataComment
                                                                  ?.createdAt ??
                                                              DateTime.now()),
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.w300,
                                                    fontSize: 10,
                                                  ),
                                                ),
                                                Obx(
                                                  () => h.userInfo.value
                                                              ?.userInfo.id ==
                                                          c.arguments!.feedData
                                                              .userInfo.id
                                                      ? CustomDropdown<String>(
                                                          onTapItem: (p0, i) {
                                                            if (i == 0) {
                                                            } else if (i == 1) {
                                                              Get.dialog(NotificationDialog(
                                                                  showCancelButton:
                                                                      true,
                                                                  cancelText:
                                                                      'Hủy',
                                                                  confirmText:
                                                                      'Xóa',
                                                                  title:
                                                                      'Xóa bình luận',
                                                                  description:
                                                                      'Bạn chắc chắn muốn xóa bình luận này? Bạn sẽ không thể khôi phục bình luận sau khi xóa.',
                                                                  onCancelBtnPressed:
                                                                      Get.back,
                                                                  onConfirmBtnPressed: () =>
                                                                      c.deleteComment(
                                                                          dataComment?.id ??
                                                                              0)));
                                                            }
                                                          },
                                                          itemBuilder:
                                                              (String item,
                                                                      int i) =>
                                                                  InkWell(
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          if (h.userInfo.value?.userInfo.id != c.arguments!.feedData.userInfo.id &&
                                                                              i ==
                                                                                  0)
                                                                            const Icon(Icons
                                                                                .report)
                                                                          else if (i ==
                                                                              0)
                                                                            const Icon(Icons
                                                                                .mode_edit_outlined)
                                                                          else if (i ==
                                                                              1)
                                                                            const Icon(Icons.delete_forever_rounded),
                                                                          const SizedBox(
                                                                              width: 4),
                                                                          Text(
                                                                            item,
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                          items: const [
                                                            'Chỉnh sửa bình luận',
                                                            'Xoá bình luận',
                                                          ],
                                                          child: const Icon(
                                                              Icons.more_horiz))
                                                      : const SizedBox(),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          )
                        : const SliverToBoxAdapter())
                  ],
                ),
              ),
              SizedBox(
                height: Get.height / 14,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                      border:
                          Border(top: BorderSide(color: theme.secondary_01))),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: c.textComment,
                          scrollPhysics: const NeverScrollableScrollPhysics(),
                          keyboardType: TextInputType.text,
                          focusNode: c.focusNode,
                          maxLines: null,
                          inputFormatters: const [],
                          decoration: InputDecoration(
                            hintText: 'Viết bình luận...',
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                          ),
                        ),
                      ),
                      Spaces.box14,
                      IconButton(
                          icon: const Icon(Icons.send),
                          onPressed: c.postComment)
                    ],
                  ),
                ),
              )
            ],
          ));
    });
  }
}
