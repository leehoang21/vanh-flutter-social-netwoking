// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:commons/commons.dart';
import 'package:finplus/utils/svg.dart';
import 'package:flutter/material.dart';

import '../../../../utils/styles.dart';
import '../../../../widgets/custom_mbs/custom_mbs.dart';

class ManageMemberMbs extends StatelessWidget {
  final id;
  final name;
  final displayPosition;
  final position;
  final Function(int id, String position)? fn;

  const ManageMemberMbs({
    super.key,
    required this.id,
    required this.name,
    required this.displayPosition,
    required this.position,
    this.fn,
  });

  @override
  Widget build(BuildContext context) {
    return CustomMbs(
      height: 350,
      body: Column(
        children: [
          InkWell(
            onTap: () {},
            child: Padding(
              padding: Spaces.h24v8,
              child: Row(
                children: [
                  SvgPicture.asset(SvgIcon.profile),
                  Spaces.box16,
                  const Text(
                    'Xem trang cá nhân',
                    style: TextDefine.T2_M,
                  ),
                ],
              ),
            ),
          ),
          const Divider(
            thickness: 1,
          ),
          if (displayPosition != 'ADMIN' && position == 'ADMIN')
            Column(
              children: [
                InkWell(
                  onTap: () {
                    fn!(id, position);
                  },
                  child: Padding(
                    padding: Spaces.h24v8,
                    child: Row(
                      children: [
                        SvgPicture.asset(SvgIcon.approve_admin),
                        Spaces.box16,
                        Text(
                          displayPosition == 'MANAGER'
                              ? 'Gỡ vai trò người kiểm duyệt'
                              : 'Thêm làm người kiểm duyệt',
                          style: TextDefine.T2_M,
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(
                  thickness: 1,
                ),
              ],
            ),
          if (displayPosition != 'ADMIN' && position == 'ADMIN')
            Column(
              children: [
                InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: Spaces.h24v8,
                    child: Row(
                      children: [
                        SvgPicture.asset(SvgIcon.delete_member),
                        Spaces.box16,
                        Text(
                          'Xóa $name khỏi nhóm',
                          style: TextDefine.T2_M,
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(
                  thickness: 1,
                ),
              ],
            ),
          InkWell(
            onTap: () {},
            child: Padding(
              padding: Spaces.h24v8,
              child: Row(
                children: [
                  SvgPicture.asset(SvgIcon.block_member),
                  Spaces.box16,
                  Text(
                    'Chặn $name',
                    style: TextDefine.T2_M,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
