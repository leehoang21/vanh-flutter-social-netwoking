import 'package:commons/commons.dart';
import 'package:finplus/finplus/screens/community/group/search_group/search_group_controller.dart';
import 'package:finplus/finplus/screens/community/group/search_group/search_group_result/search_group_result.dart';
import 'package:finplus/finplus/screens/community/group/search_group/sort_group_mbs/sort_group_mbs.dart';
import 'package:finplus/utils/svg.dart';
import 'package:flutter/material.dart';

import '../../../../../utils/styles.dart';

class SearchGroup extends StatelessWidget {
  const SearchGroup({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchGroupController>(
      init: SearchGroupController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            iconTheme: const IconThemeData(
              color: Colors.black,
            ),
            elevation: 0,
            title: Text(
              'Group',
              style: TextDefine.T1_B.copyWith(
                color: Colors.black,
              ),
            ),
            actions: [
              Container(
                height: 18,
                margin: Spaces.h16,
                child: Row(
                  children: [
                    InkWell(
                      onTap: () => Get.bottomSheet(const SortGroupMbs()),
                      child: SvgPicture.asset(
                        SvgIcon.group_sort,
                        color: const Color(0xFF17AB37),
                      ),
                    ),
                    Spaces.box16,
                    InkWell(
                      onTap: () {},
                      child: SvgPicture.asset(SvgIcon.search_group),
                    ),
                  ],
                ),
              )
            ],
            centerTitle: true,
            backgroundColor: Colors.white,
          ),
          backgroundColor: Colors.white,
          body: DefaultTabController(
            length: 3,
            initialIndex: 1,
            child: Column(
              children: [
                TabBar(
                  labelPadding: Spaces.h16v10,
                  labelColor: Colors.black,
                  labelStyle: TextDefine.P2_M,
                  unselectedLabelColor: Colors.black,
                  unselectedLabelStyle: TextDefine.P2_M,
                  indicatorColor: const Color(0xFF17AB37),
                  tabs: [
                    Tab(
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            SvgIcon.add_circle,
                            color: Colors.black,
                          ),
                          Spaces.box6,
                          const Text(
                            'Tạo',
                            style: TextDefine.P2_M,
                          )
                        ],
                      ),
                    ),
                    const Tab(
                      text: 'Nhóm phổ biến',
                    ),
                    const Tab(
                      text: 'Nhóm của bạn',
                    ),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      Container(),
                      const SearchGroupResult(),
                      const SearchGroupResult(),
                    ],
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