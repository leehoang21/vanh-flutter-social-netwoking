import 'package:commons/commons.dart';
import 'package:finplus/finplus/screens/group_member_management/manage_member_mbs/manage_member_mbs.dart';
import 'package:finplus/utils/styles.dart';
import 'package:finplus/widgets/avatar/avatar.dart';
import 'package:flutter/material.dart';

class UserRowInfo extends StatelessWidget {
  final int id;
  final String avatar;
  final String name;
  final String? displayPosition;
  final bool enableMbs;
  final bool enableBlockedBtn;
  final String position;
  final Function(int id, String position)? fn;
  const UserRowInfo({
    super.key,
    required this.id,
    required this.avatar,
    required this.name,
    this.displayPosition = '',
    this.enableMbs = true,
    this.enableBlockedBtn = false,
    this.position = '',
    this.fn,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: enableMbs
          ? () {
              Get.bottomSheet(
                ManageMemberMbs(
                  id: id,
                  name: name,
                  displayPosition: displayPosition,
                  position: position,
                  
                  fn: fn,
                ),
              );
            }
          : () {},
      child: Padding(
        padding: Spaces.v8,
        child: Row(
          children: [
            Avatar(
              value: avatar,
              size: 42,
            ),
            Spaces.box14,
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextDefine.P2_B,
                ),
                if (displayPosition != '')
                  Container(
                    alignment: Alignment.center,
                    margin: Spaces.t8,
                    width: 101,
                    height: 15,
                    decoration: const BoxDecoration(
                      color: Color(0xFFD9D9D9),
                      borderRadius: Decorate.r15,
                    ),
                    child: Text(
                      displayPosition ?? '',
                      style: TextDefine.P4_M,
                    ),
                  )
              ],
            ),
            const Spacer(),
            if (enableBlockedBtn)
              InkWell(
                onTap: () {},
                child: Container(
                  padding: Spaces.h10v6,
                  decoration: const BoxDecoration(
                    color: Color(0xFF27B45F),
                    borderRadius: Decorate.r4,
                  ),
                  child: Text(
                    'Bỏ chặn',
                    style: TextDefine.P6_M.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            else
              const SizedBox(),
          ],
        ),
      ),
    );
  }
}
