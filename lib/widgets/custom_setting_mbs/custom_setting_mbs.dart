import 'package:finplus/utils/styles.dart';
import 'package:finplus/widgets/custom_mbs/custom_mbs.dart';
import 'package:flutter/material.dart';

class CustomSettingMbs extends StatelessWidget {
  final String typeName;
  final Widget body;
  const CustomSettingMbs(
      {super.key, required this.typeName, required this.body});

  @override
  Widget build(BuildContext context) {
    return CustomMbs(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: Spaces.h20,
            child: Text(
              typeName,
              style: TextDefine.T2_B,
            ),
          ),
          Spaces.box16,
          const Divider(
            height: 1,
          ),
          Spaces.box8,
          body,
          Spaces.box36,
        ],
      ),
    );
  }
}
