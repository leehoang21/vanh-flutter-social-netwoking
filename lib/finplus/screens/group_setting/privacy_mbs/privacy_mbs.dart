import 'package:commons/commons.dart';
import 'package:finplus/utils/styles.dart';
import 'package:finplus/widgets/custom_setting_mbs/custom_setting_mbs.dart';
import 'package:flutter/material.dart';

import '../../../../models/group_info_data.dart';

class PrivacyMbs extends StatelessWidget {
  final String typeName;
  final Rx<GROUP_PRIVACY> selectedGroupPrivacy;
  final Function(GROUP_PRIVACY)? fn;
  const PrivacyMbs({
    super.key,
    required this.typeName,
    required this.selectedGroupPrivacy,
    this.fn,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.t;
    return CustomSettingMbs(
      typeName: typeName,
      body: Column(
        children: [
          ...GROUP_PRIVACY.values.map(
            (e) => Padding(
              padding: Spaces.h20v12,
              child: InkWell(
                onTap: () {
                  selectedGroupPrivacy.value = e;
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
                          Text(
                            e.desc,
                            style: TextDefine.P2_M.copyWith(
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Obx(
                      () => SizedBox(
                        height: 17,
                        width: 17,
                        child: Radio<GROUP_PRIVACY>(
                          activeColor: theme.secondary_02,
                          value: e,
                          groupValue: selectedGroupPrivacy.value,
                          onChanged: (value) {},
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
