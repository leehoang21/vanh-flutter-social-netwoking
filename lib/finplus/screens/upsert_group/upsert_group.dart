import 'package:commons/commons.dart';
import 'package:finplus/finplus/screens/upsert_group/upsert_group_controller.dart';
import 'package:flutter/material.dart';

import '../../../utils/styles.dart';
import '../../../utils/svg.dart';

class UpsertGroup extends StatelessWidget {
  const UpsertGroup({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UpsertGroupController>(
      init: UpsertGroupController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            iconTheme: const IconThemeData(
              color: Colors.black,
            ),
            title: Text(
              'Chỉnh sửa nhóm',
              style: TextDefine.T1_B.copyWith(
                color: Colors.black,
              ),
            ),
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
          ),
          body: SafeArea(
            child: Padding(
              padding: Spaces.h16v25,
              child: CustomScrollView(
                slivers: <Widget>[
                  const SliverToBoxAdapter(
                    child: Text(
                      'Tên nhóm',
                      style: TextDefine.T2_B,
                    ),
                  ),
                  SliverPadding(
                    padding: Spaces.v10,
                    sliver: SliverToBoxAdapter(
                      child: TextField(
                        minLines: 1,
                        maxLines: 2,
                        maxLength: 50,
                        controller: controller.groupName,
                        decoration: const InputDecoration(
                          fillColor: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: Spaces.v16,
                    sliver: SliverToBoxAdapter(
                        child: InkWell(
                      onTap: controller.getGroupPrivacy,
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Quyền riêng tư',
                                style: TextDefine.T2_B,
                              ),
                              Spaces.box10,
                              Obx(
                                () => Text(
                                  controller.selectedGroupPrivacy.value.title,
                                  style: TextDefine.P2_M.copyWith(
                                    color: const Color(0xFF7B7777),
                                  ),
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
                    )),
                  ),
                  const SliverToBoxAdapter(
                    child: Text(
                      'Giới thiệu về nhóm',
                      style: TextDefine.T2_B,
                    ),
                  ),
                  SliverPadding(
                    padding: Spaces.v10,
                    sliver: SliverToBoxAdapter(
                      child: TextField(
                        maxLength: 100,
                        minLines: 5,
                        maxLines: 18,
                        controller: controller.aboutGroup,
                        decoration: const InputDecoration(
                          fillColor: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: Text(
                      'Quy tắc',
                      style: TextDefine.T2_B,
                    ),
                  ),
                  SliverPadding(
                    padding: Spaces.v10,
                    sliver: SliverToBoxAdapter(
                      child: TextField(
                        maxLength: 100,
                        minLines: 5,
                        maxLines: 18,
                        controller: controller.groupRule,
                        decoration: const InputDecoration(
                          fillColor: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          alignment: Alignment.center,
                          margin: Spaces.h20v12,
                          padding: Spaces.a10,
                          width: Get.width,
                          decoration: const BoxDecoration(
                            borderRadius: Decorate.r8,
                            color: Color(0xFF17AB37),
                          ),
                          child: Text(
                            controller.kind == UpsertKind.ADD
                                ? 'Tạo nhóm'
                                : 'Lưu',
                            style: TextDefine.T1_B.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
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
