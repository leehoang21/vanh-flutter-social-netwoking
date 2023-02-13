import 'package:commons/commons.dart';
import 'package:finplus/finplus/screens/community/group/search_group/search_group_controller.dart';
import 'package:finplus/finplus/screens/community/group/search_group/search_group_result/group_info_row.dart';
import 'package:finplus/utils/styles.dart';
import 'package:flutter/material.dart';

class SearchGroupResult extends StatelessWidget {
  const SearchGroupResult({super.key});

  @override
  Widget build(BuildContext context) {
    final SearchGroupController controller = Get.find<SearchGroupController>();
    return ListView.separated(
      itemBuilder: (context, index) {
        return const GroupInfoRow(
          groupName: 'Tự học chứng khoán cho người mới bắt đầu',
          groupType: GROUP_TYPE.PRIVATE,
          numberMember: 1000,
          coverGroupImage: 'hsdsds',
        );
      },
      separatorBuilder: (context, index) => Spaces.box4,
      itemCount: 10,
    );
  }
}
