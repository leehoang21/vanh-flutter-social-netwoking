import 'package:commons/commons.dart';
import 'package:finplus/finplus/screens/group_management/group_management_controller.dart';
import 'package:finplus/utils/svg.dart';
import 'package:flutter/material.dart';

import '../../../utils/styles.dart';

class GroupManagement extends StatelessWidget {
  const GroupManagement({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GroupManagementController>(
      init: GroupManagementController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            iconTheme: const IconThemeData(
              color: Colors.black,
            ),
            title: Text(
              'Quản trị nhóm',
              style: TextDefine.T1_B.copyWith(
                color: Colors.black,
              ),
            ),
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
          ),
          body: SafeArea(
            child: Column(
              children: [
                Container(
                  padding: Spaces.h16v10,
                  alignment: Alignment.centerLeft,
                  color: const Color(0xFFB0E1BB).withOpacity(0.4),
                  child: const Text(
                    'Quản trị bài viết',
                    style: TextDefine.T2_B,
                  ),
                ),
                Spaces.box12,
                ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final item = controller.getManageGroupType(index);
                    return InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: Spaces.h24v8,
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              item.icon,
                              color: const Color(0xFF17AB37),
                            ),
                            Spaces.box16,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.type,
                                  style: TextDefine.P4_B,
                                ),
                                Text(
                                  '0 ${item.remaining}',
                                  style: TextDefine.P3_R.copyWith(
                                    color: const Color(0xFF7B7777),
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            const Text(
                              '0',
                              style: TextDefine.T2_B,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => const Divider(
                    thickness: 1,
                  ),
                  itemCount: 3,
                ),
                const Divider(
                  thickness: 1,
                ),
                Spaces.box64,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {},
                          child: SvgPicture.asset(SvgIcon.share),
                        ),
                        Spaces.box12,
                        const Text(
                          'Chia sẻ nhóm',
                          style: TextDefine.P2_B,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        InkWell(
                          onTap: () {},
                          child: SvgPicture.asset(SvgIcon.delete),
                        ),
                        Spaces.box12,
                        const Text(
                          'Xoá nhóm',
                          style: TextDefine.P2_B,
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
