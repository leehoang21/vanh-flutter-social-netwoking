import 'package:commons/commons.dart';
import 'package:finplus/finplus/screens/create_chat_room/select_image/select_image_mbs_controller.dart';
import 'package:finplus/utils/styles.dart';
import 'package:finplus/widgets/custom_mbs/custom_mbs.dart';
import 'package:flutter/material.dart';

class SelectImageMbs extends StatelessWidget {
  final Function(String imagePath) onSelected;
  const SelectImageMbs({
    super.key,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.t;
    return GetBuilder<SelectImageMbsController>(
        init: SelectImageMbsController(onSelected: onSelected),
        builder: (c) {
          return CustomMbs(
            body: Column(
              children: [
                const Text(
                  'Cập nhật ảnh đại diện',
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: c.imgFromGallery,
                        child: Container(
                          width: double.infinity,
                          padding: Spaces.h16v20,
                          child: const Text(
                            'Chọn từ thư viện',
                            style: TextDefine.P1_M,
                          ),
                        ),
                      ),
                      const Divider(
                        height: 1,
                        thickness: 1,
                      ),
                      InkWell(
                        onTap: c.imgFromCamera,
                        child: Container(
                          width: double.infinity,
                          padding: Spaces.h16v20,
                          child: const Text(
                            'Chụp ảnh',
                            style: TextDefine.P1_M,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
