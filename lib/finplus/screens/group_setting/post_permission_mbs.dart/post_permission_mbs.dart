import 'package:commons/commons.dart';
import 'package:finplus/utils/styles.dart';
import 'package:finplus/widgets/custom_setting_mbs/custom_setting_mbs.dart';
import 'package:flutter/material.dart';

import '../../../../utils/svg.dart';

// ignore: camel_case_types
enum POST_PERMISSION {
  EVERYONE(
    icon: SvgIcon.member,
    title: 'Bất cứ ai trong nhóm',
  ),
  ADMIN(
    icon: SvgIcon.group_management,
    title: 'Chỉ có quản trị viên và người kiểm duyệt',
  );

  final String icon;
  final String title;

  const POST_PERMISSION({
    required this.icon,
    required this.title,
  });
}

// ignore: must_be_immutable
class PostPermissionMbs extends StatelessWidget {
  String typeName;
  Rx<POST_PERMISSION> selectedPostPermission;
  Function(POST_PERMISSION)? fn;
  PostPermissionMbs({
    super.key,
    required this.typeName,
    required this.selectedPostPermission,
    this.fn,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.t;
    return CustomSettingMbs(
      typeName: typeName,
      body: Column(
        children: [
          ...POST_PERMISSION.values.map(
            (e) => Padding(
              padding: Spaces.h20v12,
              child: InkWell(
                onTap: () {
                  selectedPostPermission.value = e;
                  if (fn != null) {
                    fn!(e);
                  } else {}
                },
                child: Row(
                  children: [
                    SizedBox(
                      height: 24,
                      width: 24,
                      child: SvgPicture.asset(
                        e.icon,
                        color: const Color(0xFF17AB37),
                      ),
                    ),
                    Spaces.box16,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            e.title,
                            style: TextDefine.P1_M,
                          ),
                        ],
                      ),
                    ),
                    Obx(
                      () => SizedBox(
                        height: 17,
                        width: 17,
                        child: Radio<POST_PERMISSION>(
                          activeColor: theme.secondary_02,
                          value: e,
                          groupValue: selectedPostPermission.value,
                          onChanged: (value) {},
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
