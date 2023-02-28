import 'package:commons/commons.dart';
import 'package:finplus/finplus/screens/community/community_controller.dart';
import 'package:finplus/finplus/screens/community/popular_group/popular_group.dart';
import 'package:finplus/finplus/screens/home/home_controller.dart';
import 'package:finplus/routes/finplus_routes.dart';
import 'package:finplus/utils/styles.dart';
import 'package:finplus/widgets/avatar/avatar.dart';
import 'package:finplus/widgets/button/button.dart';
import 'package:flutter/material.dart';

import 'new_feed/feed_container.dart';

class Community extends StatelessWidget with HomeControllerMinxin {
  Community({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.t;
    final HomeController h = Get.find();
    return GetBuilder<CommunityController>(builder: (c) {
      return Scaffold(
        floatingActionButton: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Button(
              onPressed: () => Get.toNamed(Routes.chat_room),
              child: Text(
                'Chat room',
                style: TextDefine.P1_B.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            Spaces.boxH16,
            Button(
              onPressed: () => Get.offAndToNamed(Routes.login),
              child: Text(
                'Đăng xuất',
                style: TextDefine.P1_B.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFFF6F7F8),
        body: CustomScrollView(
          slivers: [
            const SliverPadding(padding: EdgeInsets.only(top: 30)),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              sliver: SliverToBoxAdapter(
                child: Row(
                  children: [
                    Avatar(value: h.userInfo.value?.userInfo.avatar ?? ''),
                    Spaces.boxW10,
                    Expanded(
                      child: Container(
                        padding: Spaces.h12v16,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                offset: const Offset(0, 1),
                                blurRadius: 5,
                                color: theme.secondary_01.withOpacity(0.5))
                          ],
                          borderRadius: Decorate.r24,
                        ),
                        child: InkWell(
                          onTap: () => Get.toNamed(Routes.create_post)
                              ?.then((value) => c.creatFeed(value)),
                          child: Text(
                            'Bạn đang nghĩ gì?',
                            style: TextDefine.P2_R
                                .copyWith(color: theme.primary_01),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.only(left: 12, right: 12, bottom: 20),
              sliver: SliverToBoxAdapter(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Nhóm phổ biến',
                      style: TextDefine.T1_M.copyWith(
                          color: theme.primary_02, fontWeight: FontWeight.w700),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.transparent,
                      ),
                      onPressed: () => Get.toNamed(Routes.search_group),
                      child: Text(
                        'Xem tất cả',
                        style:
                            TextDefine.P3_R.copyWith(color: theme.primary_04),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const PopularGroup(),
            SliverPadding(
              padding: const EdgeInsets.only(
                  left: 12, right: 12, bottom: 10, top: 22),
              sliver: SliverToBoxAdapter(
                child: Text(
                  'News Feed',
                  style: TextDefine.T1_M.copyWith(
                      color: theme.primary_02, fontWeight: FontWeight.w700),
                ),
              ),
            ),
            Obx(
              () => SliverList(
                delegate: SliverChildBuilderDelegate(
                  childCount: c.feedDataList.value.length,
                  (context, index) => FeedContainer(
                    userId: userInfo?.userInfo.id ?? -1,
                    feedData: c.feedDataList.value[index],
                    onDeletedPost: () =>
                        c.deletePost(c.feedDataList.value[index].id),
                  ),
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}
