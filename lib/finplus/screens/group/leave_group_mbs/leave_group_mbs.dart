import 'package:finplus/utils/styles.dart';
import 'package:finplus/widgets/custom_mbs/custom_mbs.dart';
import 'package:flutter/material.dart';

class LeaveGroupMbs extends StatelessWidget {
  const LeaveGroupMbs({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomMbs(
      height: 150,
      body: InkWell(
        onTap: () {},
        child: const Text(
          'Rời khỏi nhóm',
          style: TextDefine.P1_M,
        ),
      ),
    );
  }
}
