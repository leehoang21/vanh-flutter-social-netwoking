import 'package:commons/commons.dart';
import 'package:finplus/finplus/screens/about_group/about_group_controller.dart';
import 'package:finplus/utils/styles.dart';
import 'package:finplus/widgets/user_row_info/user_row_info.dart';
import 'package:flutter/material.dart';

import '../../../models/group_info_data.dart';
import '../../../utils/svg.dart';
import '../../../widgets/avatar/avatar.dart';

class AboutGroup extends StatelessWidget {
  const AboutGroup({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AboutGroupController>(
      init: AboutGroupController(),
      builder: (controller) {
        final GroupInfoData groupInfoData = controller.groupInfoData.value;
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: SizedBox(
              width: Get.width * 0.68,
              child: Text(
                groupInfoData.name,
                overflow: TextOverflow.ellipsis,
                style: TextDefine.T1_B,
              ),
            ),
          ),
          body: SafeArea(
            child: Padding(
              padding: Spaces.h20,
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverToBoxAdapter(
                    child: Container(
                      padding: Spaces.v16,
                      width: Get.width,
                      decoration: const BoxDecoration(
                        color: Color(0xFFF6FCF4),
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(50),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Giới thiệu',
                            style: TextDefine.T1_B,
                          ),
                          Spaces.box12,
                          Text(
                            'Tự học code',
                            style: TextDefine.P2_M.copyWith(
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Spaces.box12
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SvgPicture.asset(SvgIcon.private),
                        Spaces.box14,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                groupInfoData.privacy.title,
                                style: TextDefine.T2_B,
                              ),
                              Spaces.box6,
                              Text(
                                groupInfoData.privacy.desc,
                                style: TextDefine.P3_R,
                              ),
                              Spaces.box12,
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: Text(
                      'Nhóm quản trị',
                      style: TextDefine.T1_B,
                    ),
                  ),
                  SliverPadding(
                    padding: Spaces.v10,
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          final item = groupInfoData.adminsGroup[index];
                          return UserRowInfo(
                            id: item,
                            avatar: 'avatar',
                            name: item.toString(),
                            displayPosition: 'ADMIN',
                            enableMbs: false,
                            fn: (id, position) {},
                          );
                        },
                        childCount: groupInfoData.adminsGroup.length,
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Rule from admin',
                          style: TextDefine.T1_B,
                        ),
                        Spaces.box12,
                        Text(
                          'Quy tắc',
                          style: TextDefine.P2_M.copyWith(
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SliverPadding(
                    padding: Spaces.v16,
                    sliver: SliverToBoxAdapter(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Thành viên',
                            style: TextDefine.T1_B,
                          ),
                          InkWell(
                            onTap: () {
                              // Get.toNamed(
                              //   Routes.group_member_management,
                              //   arguments: GroupMemberManagementArgument(
                              //     listGroupMember: controller.listGroupMember,
                              //     groupInfoData: controller.groupInfoData,
                              //   ),
                              // );
                            },
                            child: Text(
                              'Xem tất cả',
                              style: TextDefine.P4_R.copyWith(
                                color: const Color(0xFF27B45F),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 42,
                      child: ListView.separated(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => InkWell(
                          onTap: () {},
                          child: Avatar(
                            size: 42,
                            value:
                                controller.listGroupMember[index].avatar ?? '',
                          ),
                        ),
                        itemCount: controller.getLimitAvatarDisplay,
                        separatorBuilder: (context, index) => Spaces.box4,
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: Spaces.v12,
                    sliver: SliverToBoxAdapter(
                      child: Text(
                        '${groupInfoData.members} thành viên đã tham gia',
                        style: TextDefine.P3_R.copyWith(
                          color: const Color(0xFF7D7B7B),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
