import 'package:cached_network_image/cached_network_image.dart';
import 'package:commons/commons.dart';
import 'package:finplus/finplus/screens/about_group/about_group.dart';
import 'package:finplus/finplus/screens/create_post/create_post.dart';
import 'package:finplus/finplus/screens/group/group_controller.dart';
import 'package:finplus/finplus/screens/group_management/group_management.dart';
import 'package:finplus/finplus/screens/group_setting/group_setting.dart';
import 'package:finplus/utils/styles.dart';
import 'package:finplus/utils/svg.dart';
import 'package:flutter/material.dart';

import '../../../widgets/avatar/avatar.dart';
import '../community/new_feed/feed_view_container.dart';
import '../home/home_controller.dart';

class Group extends StatelessWidget with HomeControllerMinxin {
  Group({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.t;
    return GetBuilder<GroupController>(
      init: GroupController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            actions: <Widget>[
              InkWell(
                onTap: () {},
                child: SvgPicture.asset(
                  SvgIcon.search_group,
                  color: Colors.white,
                ),
              ),
              Spaces.box16,
              InkWell(
                onTap: () {
                  Get.to(() => const GroupManagement());
                },
                child: SvgPicture.asset(
                  SvgIcon.group_management,
                  color: Colors.white,
                ),
              ),
              Spaces.box16,
              InkWell(
                onTap: () {
                  Get.to(() => const GroupSetting());
                },
                child: SvgPicture.asset(
                  SvgIcon.setting,
                  color: Colors.white,
                ),
              ),
              Spaces.box32,
            ],
          ),
          body: CustomScrollView(
            slivers: <Widget>[
              SliverToBoxAdapter(
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CachedNetworkImage(
                      width: Get.width,
                      height: 200,
                      imageUrl:
                          'https://images.unsplash.com/photo-1661956602153-23384936a1d3?ixlib=rb-4.0.3&ixid=MnwxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=3270&q=80',
                      fit: BoxFit.fill,
                    ),
                    InkWell(
                      onTap: () {
                        controller.pickImage();
                      },
                      child: Container(
                        height: 20,
                        width: 20,
                        margin: Spaces.h16v25,
                        child: SvgPicture.asset(
                          SvgIcon.camera,
                          color: const Color(0xFFD9D9D9),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: InkWell(
                  onTap: () {
                    Get.to(() => const AboutGroup());
                  },
                  child: Container(
                    padding: Spaces.h20v12,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Expanded(
                              child: Text(
                                'Nhóm 1',
                                style: TextDefine.T1_M,
                              ),
                            ),
                            SizedBox(
                              height: 17,
                              child: SvgPicture.asset(SvgIcon.right),
                            ),
                          ],
                        ),
                        Spaces.box14,
                        Row(
                          children: [
                            SvgPicture.asset(SvgIcon.private),
                            Spaces.boxW8,
                            const Text(
                              'Nhóm công khai',
                              style: TextDefine.P3_M,
                            ),
                            Spaces.boxW16,
                            SizedBox(
                              height: 20,
                              width: 20,
                              child: SvgPicture.asset(
                                SvgIcon.member,
                                color: const Color(0xFFD9D9D9),
                              ),
                            ),
                            Spaces.boxW5,
                            const Text(
                              '20',
                              style: TextDefine.P3_M,
                            ),
                            Spaces.boxW16,
                            SizedBox(
                              height: 20,
                              width: 20,
                              child: SvgPicture.asset(
                                SvgIcon.number_post,
                              ),
                            ),
                            Spaces.boxW5,
                            const Text(
                              '10',
                              style: TextDefine.P3_M,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Row(
                  children: [
                    Spaces.box36,
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          height: 36,
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 31, 152, 80),
                            borderRadius: Decorate.r8,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                SvgIcon.joined,
                              ),
                              Spaces.boxW5,
                              Text(
                                'Đã tham gia',
                                style: TextDefine.P3_B.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                              Spaces.boxW8,
                              SvgPicture.asset(
                                height: 5,
                                SvgIcon.down,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Spaces.box36,
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          height: 36,
                          decoration: const BoxDecoration(
                            color: Color(0xFF27B45F),
                            borderRadius: Decorate.r8,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                height: 11,
                                SvgIcon.add_member,
                              ),
                              Spaces.boxW5,
                              Text(
                                'Mời',
                                style: TextDefine.P3_B.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Spaces.box36,
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  margin: Spaces.v16,
                  padding: Spaces.h20v12,
                  decoration: const BoxDecoration(
                    border: Border.symmetric(
                      horizontal: BorderSide(
                        color: Color(0xFFD9D9D9),
                        width: 1,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      const Avatar(
                        value: '',
                        size: 38,
                      ),
                      Spaces.boxW16,
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Get.to(
                              () => const CreatePost(
                                inHome: false,
                              ),
                            );
                          },
                          child: Container(
                            alignment: Alignment.centerLeft,
                            padding: Spaces.h16v10,
                            height: 40,
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16)),
                              color: Color(0xFFF6F7F8),
                            ),
                            child: const Text(
                              'Bạn đang nghĩ gì',
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 12,
                                color: Color(0xFF767272),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: Spaces.h16v10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Bài viết',
                        style: TextDefine.P1_M,
                      ),
                      InkWell(
                        onTap: () {},
                        child: SvgPicture.asset(SvgIcon.more),
                      ),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.only(
                    left: 12, right: 12, bottom: 10, top: 22),
                sliver: SliverToBoxAdapter(
                  child: InkWell(
                    onTap: controller.onRefresh,
                    child: Text(
                      'Refresh',
                      style: TextDefine.T1_M.copyWith(
                          color: theme.primary_02, fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ),
              Obx(
                () => SliverToBoxAdapter(
                  child: Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.listPost.value.length,
                      itemBuilder: (context, index) {
                        final post = controller.listPost.value[index];
                        return FeedViewContainer(
                          name: post.name,
                          uid: post.uid,
                          content: post.content,
                          timestamp: post.time,
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
