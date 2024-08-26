import 'package:finplus/widgets/user_row_info/user_row_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../utils/styles.dart';

class BlockedMember extends StatelessWidget {
  const BlockedMember({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        title: Text(
          'Đã chặn',
          style: TextDefine.T1_B.copyWith(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
      ),
      body: Padding(
        padding: Spaces.a20,
        child: CustomScrollView(
          slivers: <Widget>[
            const SliverToBoxAdapter(
              child: CupertinoSearchTextField(),
            ),
            SliverPadding(
              padding: Spaces.v16,
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return const UserRowInfo(
                      id: 1,
                      avatar: '',
                      name: 'Trần Thuỳ Linh',
                      enableBlockedBtn: true,
                    );
                  },
                  childCount: 5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
