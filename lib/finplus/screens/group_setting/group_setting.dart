import 'package:commons/commons.dart';
import 'package:finplus/finplus/screens/group_setting/group_setting_controller.dart';
import 'package:finplus/utils/svg.dart';
import 'package:flutter/material.dart';

import '../../../utils/styles.dart';

class GroupSetting extends StatelessWidget {
  const GroupSetting({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GroupSettingController>(
      init: GroupSettingController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            iconTheme: const IconThemeData(
              color: Colors.black,
            ),
            title: Text(
              'Cài đặt nhóm',
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
                    'Thiết lập nhóm',
                    style: TextDefine.T2_B,
                  ),
                ),
                Spaces.box8,
                ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final item = controller.getGroupSetting(index);
                    return InkWell(
                      onTap: item.fn,
                      child: Padding(
                        padding: Spaces.h24v8,
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.title,
                                  style: TextDefine.P4_B,
                                ),
                                if (item.type != null)
                                  Obx(
                                    () => Text(
                                      item.type!.value,
                                      style: TextDefine.P3_R.copyWith(
                                        color: const Color(0xFF7B7777),
                                      ),
                                    ),
                                  )
                                else
                                  const SizedBox(),
                              ],
                            ),
                            const Spacer(),
                            SizedBox(
                              height: 17,
                              child: SvgPicture.asset(SvgIcon.right),
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
                Container(
                  padding: Spaces.h16v10,
                  alignment: Alignment.centerLeft,
                  color: const Color(0xFFB0E1BB).withOpacity(0.4),
                  child: const Text(
                    'Quản lí bài viết',
                    style: TextDefine.T2_B,
                  ),
                ),
                Spaces.box8,
                ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final item = controller.getManagePostSetting(index);
                    return InkWell(
                      onTap: item.fn,
                      child: Padding(
                        padding: Spaces.h24v8,
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.title,
                                  style: TextDefine.P4_B,
                                ),
                                if (item.type != null)
                                  Obx(
                                    () => Text(
                                      item.type!.value,
                                      style: TextDefine.P3_R.copyWith(
                                        color: const Color(0xFF7B7777),
                                      ),
                                    ),
                                  )
                                else
                                  const SizedBox(),
                              ],
                            ),
                            const Spacer(),
                            SizedBox(
                              height: 17,
                              child: SvgPicture.asset(SvgIcon.right),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => const Divider(
                    thickness: 1,
                  ),
                  itemCount: 4,
                ),
                Container(
                  padding: Spaces.h16v10,
                  alignment: Alignment.centerLeft,
                  color: const Color(0xFFB0E1BB).withOpacity(0.4),
                  child: const Text(
                    'Quản lí thành viên',
                    style: TextDefine.T2_B,
                  ),
                ),
                Spaces.box8,
                InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: Spaces.h24v8,
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Ai có thể phê duyệt thành viên',
                              style: TextDefine.P4_B,
                            ),
                            Text(
                              'Bất cứ ai trong nhóm',
                              style: TextDefine.P3_R.copyWith(
                                color: const Color(0xFF7B7777),
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        SizedBox(
                          height: 17,
                          child: SvgPicture.asset(SvgIcon.right),
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(
                  height: 1,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
