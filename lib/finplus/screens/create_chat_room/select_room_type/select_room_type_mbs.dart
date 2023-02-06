import 'package:commons/commons.dart';
import 'package:finplus/providers/chat_provider/chat_provider.dart';
import 'package:finplus/utils/styles.dart';
import 'package:finplus/widgets/custom_mbs/custom_mbs.dart';
import 'package:flutter/material.dart';

class SelectRoomTypeMbs extends StatelessWidget {
  final Rx<ROOM_TYPE> valueSelected;
  const SelectRoomTypeMbs({super.key, required this.valueSelected});

  @override
  Widget build(BuildContext context) {
    final theme = context.t;
    return CustomMbs(
      body: Column(
        children: [
          const Text(
            'Chọn chế độ riêng tư',
            style: TextDefine.H2_M,
          ),
          Container(
            margin: Spaces.h16v12,
            decoration: BoxDecoration(
              color: theme.background,
              borderRadius: Decorate.r15,
              boxShadow: [
                BoxShadow(
                  color: theme.shadow,
                  blurRadius: 2,
                )
              ],
            ),
            child: Column(
              children: [
                ...ROOM_TYPE.values.map(
                  (e) => Column(
                    children: [
                      InkWell(
                        onTap: () {
                          valueSelected(e);
                          Get.back();
                        },
                        child: Container(
                          padding: Spaces.h16v12,
                          child: Row(
                            children: [
                              SvgPicture.asset(e.icon),
                              Spaces.boxW16,
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      e.title,
                                      style: TextDefine.P1_M,
                                    ),
                                    Spaces.box8,
                                    Text(e.desc),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 24,
                                width: 24,
                                child: Obx(
                                  () => Radio<ROOM_TYPE>(
                                    activeColor: Colors.greenAccent,
                                    value: e,
                                    groupValue: valueSelected.value,
                                    onChanged: (value) {
                                      valueSelected(value);
                                      Get.back();
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (e != ROOM_TYPE.values.last)
                        const Divider(
                          height: 1,
                          thickness: 1,
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
