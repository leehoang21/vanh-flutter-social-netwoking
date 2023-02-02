import 'package:commons/commons.dart';
import 'package:finplus/utils/styles.dart';
import 'package:finplus/utils/svg.dart';
import 'package:finplus/widgets/avatar/avatar.dart';
import 'package:finplus/widgets/custom_mbs/custom_mbs.dart';
import 'package:flutter/material.dart';

class UserReactMbs extends StatelessWidget {
  const UserReactMbs({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.t;
    return CustomMbs(
      height: Get.height / 2,
      body: DefaultTabController(
        length: 1,
        child: Column(
          children: [
            const Text('0 người đã bày tỏ cảm xúc'),
            Spaces.box14,
            const Divider(
              height: 1,
              thickness: 1,
            ),
            TabBar(
              labelPadding: Spaces.a10,
              labelStyle: TextDefine.P2_B,
              labelColor: theme.textContent,
              unselectedLabelStyle: TextDefine.P2_M,
              unselectedLabelColor: theme.textDisable,
              indicatorColor: theme.primary_01,
              padding: EdgeInsets.zero,
              tabs: const [
                Text(
                  'Tất cả',
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     SvgPicture.asset(
                //       SvgIcon.angry_icon,
                //     ),
                //     Spaces.boxW5,
                //     const Text('0'),
                //   ],
                // ),
              ],
            ),
            const Divider(
              height: 1,
              thickness: 1,
            ),
            Expanded(
              child: TabBarView(
                children: [
                  ListView(
                    children: [
                      Padding(
                        padding: Spaces.a8,
                        child: Row(
                          children: [
                            const Avatar(
                              url: '',
                            ),
                            Spaces.boxW5,
                            const Expanded(
                              child: Text(
                                'Tên',
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const Spacer(),
                            SvgPicture.asset(
                              SvgIcon.angry_icon,
                            ),
                            Spaces.boxW5,
                            const Text('0'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget _buildStackIcons() {
  //   final List<String> listIconTemp = [
  //     SvgIcon.angry_icon,
  //     SvgIcon.fun_icon,
  //   ];
  //   return Stack(
  //     children: [
  //       for (int i = 0; i < listIconTemp.length; i++)
  //         Padding(
  //           padding: EdgeInsets.only(left: i * 10),
  //           child: SvgPicture.asset(
  //             listIconTemp[i],
  //           ),
  //         )
  //     ],
  //   );
  // }
}
