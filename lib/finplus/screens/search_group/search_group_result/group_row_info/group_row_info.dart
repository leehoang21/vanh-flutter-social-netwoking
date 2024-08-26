import 'package:cached_network_image/cached_network_image.dart';
import 'package:commons/commons.dart';
import 'package:finplus/utils/svg.dart';
import 'package:finplus/widgets/avatar/avatar.dart';
import 'package:flutter/material.dart';

import '../../../../../models/group_info_data.dart';
import '../../../../../utils/styles.dart';

class GroupRowInfo extends StatelessWidget {
  const GroupRowInfo({
    super.key,
    required this.groupInfoData,
  });

  final RxGroupInfoData groupInfoData;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        height: 120,
        margin: Spaces.h10v6,
        decoration: BoxDecoration(
          borderRadius: Decorate.r16,
          border: Border.all(
            color: Colors.black,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                padding: Spaces.a16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(
                      () => Text(
                        groupInfoData.name,
                        style: TextDefine.P2_B,
                      ),
                    ),
                    Spaces.box10,
                    Row(
                      children: [
                        SizedBox(
                          height: 12,
                          width: 12,
                          child: SvgPicture.asset(
                            SvgIcon.private_group,
                          ),
                        ),
                        Spaces.boxW5,
                        Obx(
                          () => Text(
                            groupInfoData.privacy.title,
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const Spacer(),
                        SizedBox(
                          height: 12,
                          width: 12,
                          child: SvgPicture.asset(
                            SvgIcon.member,
                          ),
                        ),
                        Spaces.boxW5,
                        Text(
                          '${groupInfoData.members}',
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.horizontal(
                      right: Radius.circular(16),
                    ),
                    child: CachedNetworkImage(
                      width: Get.width,
                      height: Get.height,
                      imageUrl:
                          'https://images.unsplash.com/photo-1661956602153-23384936a1d3?ixlib=rb-4.0.3&ixid=MnwxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=3270&q=80',
                      fit: BoxFit.fill,
                    ),
                  ),
                  Positioned(
                    top: 0,
                    child: Container(
                      height: 50,
                      width: 30,
                      padding: Spaces.a3,
                      margin: Spaces.h5v10,
                      decoration: const BoxDecoration(
                        borderRadius: Decorate.r16,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 20,
                            width: 20,
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: Decorate.r15,
                            ),
                            child: const Text(
                              '1k',
                              style: TextStyle(
                                fontSize: 10,
                              ),
                            ),
                          ),
                          const Avatar(
                            value: '',
                            size: 20,
                          )
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      padding: Spaces.h10v6,
                      margin: Spaces.a8,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        color: Color(0xFF17AB37),
                        borderRadius: Decorate.r16,
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            height: 18,
                            child: SvgPicture.asset(
                              SvgIcon.add_member,
                            ),
                          ),
                          Spaces.box4,
                          Text(
                            'Join',
                            style: TextDefine.P2_M.copyWith(
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}