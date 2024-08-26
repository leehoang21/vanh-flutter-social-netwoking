import 'package:commons/commons.dart';
import 'package:finplus/finplus/screens/group_member_management/group_member_management_controller.dart';
import 'package:finplus/utils/svg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../utils/styles.dart';
import '../../../widgets/user_row_info/user_row_info.dart';

class GroupMemberManagement extends StatelessWidget {
  const GroupMemberManagement({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GroupMemberManagementController>(
      init: GroupMemberManagementController(),
      builder: (controller) {
        final listGroupMember = controller.listGroupMember;
        final groupInfoData = controller.groupInfoData;
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            iconTheme: const IconThemeData(
              color: Colors.black,
            ),
            title: Text(
              'Thành viên',
              style: TextDefine.T1_B.copyWith(
                color: Colors.black,
              ),
            ),
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
          ),
          body: SafeArea(
            child: Padding(
              padding: Spaces.h20,
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverToBoxAdapter(
                    child: Container(
                      margin: Spaces.v16,
                      padding: Spaces.h10v6,
                      decoration: const BoxDecoration(
                        color: Color(0xFFF6F7F8),
                        borderRadius: Decorate.r8,
                      ),
                      child: InkWell(
                        onTap: () {},
                        child: Row(
                          children: [
                            SvgPicture.asset(SvgIcon.blocked_member),
                            Spaces.boxW16,
                            const Text(
                              'Đã chặn',
                              style: TextDefine.T2_M,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: CupertinoSearchTextField(),
                  ),
                  const SliverPadding(
                    padding: Spaces.v8,
                    sliver: SliverToBoxAdapter(
                      child: Text(
                        'Quản trị viên và người kiểm duyệt',
                        style: TextDefine.T2_B,
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        final item = groupInfoData.adminsGroup[index];
                        return UserRowInfo(
                          id: item,
                          avatar: 'avatar',
                          name: item.toString(),
                          displayPosition: 'ADMIN',
                          position: controller.position,
                        );
                      },
                      childCount: groupInfoData.adminsGroup.length,
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        final item = groupInfoData.managersGroup[index];
                        return UserRowInfo(
                          id: item,
                          avatar: 'avatar',
                          name: item.toString(),
                          displayPosition: 'MANAGER',
                          position: controller.position,
                        );
                      },
                      childCount: groupInfoData.managersGroup.length,
                    ),
                  ),
                  const SliverPadding(
                    padding: Spaces.v8,
                    sliver: SliverToBoxAdapter(
                      child: Text(
                        'Thành viên',
                        style: TextDefine.T2_B,
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        final item = listGroupMember[index];
                        return UserRowInfo(
                          id: item.id,
                          avatar: item.avatar ?? '',
                          name: item.name ?? '',
                          position: controller.position,
                        );
                      },
                      childCount: listGroupMember.length,
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
