import 'dart:io';

import 'package:commons/commons.dart';
import 'package:finplus/finplus/screens/create_chat_room/create_chat_room_controller.dart';
import 'package:finplus/finplus/screens/create_chat_room/select_image/select_image_mbs.dart';
import 'package:finplus/utils/styles.dart';
import 'package:finplus/utils/svg.dart';
import 'package:finplus/widgets/button/button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateChatRoom extends StatelessWidget {
  const CreateChatRoom({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.t;
    return GetBuilder<CreateChatRoomController>(
      init: CreateChatRoomController(),
      builder: (c) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: const Text('Tạo nhóm chat'),
            ),
            body: Padding(
              padding: Spaces.h16v12,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Ảnh đại diện',
                      style: TextDefine.P2_M,
                    ),
                  ),
                  Spaces.box10,
                  Align(
                    alignment: Alignment.center,
                    child: InkWell(
                      onTap: () => Get.bottomSheet(
                        SelectImageMbs(
                          onSelected: (value) {
                            c.imagePath(value);
                          },
                        ),
                        ignoreSafeArea: false,
                        isScrollControlled: true,
                      ),
                      child: CircleAvatar(
                        backgroundColor: theme.primary_03,
                        radius: 102 / 2,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100 / 2),
                          child: Obx(
                            () => c.imagePath.value == null
                                ? Container(
                                    width: 100,
                                    height: 100,
                                    child: Center(
                                      child: SvgPicture.asset(
                                        SvgIcon.camera_icon,
                                        color: Colors.black,
                                      ),
                                    ),
                                    color: theme.background,
                                  )
                                : Image.file(
                                    File(c.imagePath.value!.path),
                                    fit: BoxFit.cover,
                                    width: 100,
                                    height: 100,
                                  ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Spaces.box20,
                  const Text(
                    'Tên nhóm',
                    style: TextDefine.P2_M,
                  ),
                  Spaces.box10,
                  TextField(
                    controller: c.nameRoomController,
                    onChanged: c.enableCreateRoomHandler,
                    decoration: const InputDecoration(
                      hintText: 'Nhập tên nhóm',
                    ),
                  ),
                  Spaces.box20,
                  const Text(
                    'Chế độ riêng tư',
                    style: TextDefine.P2_M,
                  ),
                  Spaces.box10,
                  InkWell(
                    onTap: c.changeRoomTypeHandler,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 8),
                      child: Row(
                        children: [
                          Obx(
                            () => Text(
                              c.roomType.value.name,
                              style: TextDefine.P1_R,
                            ),
                          ),
                          const Spacer(),
                          const Icon(CupertinoIcons.chevron_down)
                        ],
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: theme.primary_03,
                        ),
                        borderRadius: Decorate.r8,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Obx(
                    () => Button(
                      type: ButtonType.fill,
                      child: const Text('Tạo nhóm chat'),
                      onPressed: c.enableCreate.value ? c.createRoomChat : null,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
