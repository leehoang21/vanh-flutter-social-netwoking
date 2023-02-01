import 'package:commons/commons.dart';
import 'package:finplus/finplus/screens/community/widget/community_popular_group.dart';
import 'package:finplus/utils/styles.dart';
import 'package:flutter/material.dart';

import 'widget/community_new_feed.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7F8),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFFFF),
        leading: IconButton(
            onPressed: Get.back,
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
              size: 24,
            )),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              color: Color(0xff14C53B),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.group,
              color: Color(0xff14C53B),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications_rounded,
              color: Color(0xff14C53B),
            ),
          ),
        ],
        title: const Text(
          'Community',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            sliver: SliverToBoxAdapter(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color(0xFFFFFFFF),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 14,
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: const Placeholder(
                            fallbackHeight: 38,
                            fallbackWidth: 38,
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          maxLines: null,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xFFF6F7F8),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Color(0xFFF6F7F8),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Color(0xFFF6F7F8),
                              ),
                            ),
                            hintText: 'Bạn đang nghĩ gì',
                            hintStyle: const TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(left: 12, right: 12, bottom: 20),
            sliver: SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Nhóm phổ biến',
                    style: TextDefine.P6_M,
                  ),
                  Text(
                    'Xem tất cả',
                    style: TextStyle(
                      color: Color(0xFF17AB37),
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const CommunityPopularGroupScreen(),
          const SliverPadding(
            padding: EdgeInsets.only(left: 12, right: 12, bottom: 10, top: 22),
            sliver: SliverToBoxAdapter(
              child: Text(
                'New Feed',
                style: TextDefine.P6_M,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: 1,
              (context, index) => const CommunityNewFeed(),
            ),
          ),
        ],
      ),
    );
  }
}
