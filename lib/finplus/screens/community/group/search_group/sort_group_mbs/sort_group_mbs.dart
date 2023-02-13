import 'package:commons/commons.dart';
import 'package:finplus/finplus/screens/community/group/search_group/search_group_controller.dart';
import 'package:finplus/utils/styles.dart';
import 'package:finplus/utils/svg.dart';
import 'package:finplus/widgets/custom_mbs/custom_mbs.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
enum SORT_TYPE {
  MOST_FREQUENTLY,
  SORT_BY_A_Z,
  RECENTLY,
}

class SortType {
  final String icon;
  final String sortType;
  final SORT_TYPE type;

  const SortType({
    required this.icon,
    required this.sortType,
    required this.type,
  });
}

const _sortType = [
  SortType(
    icon: SvgIcon.frequent,
    sortType: 'Truy cập thường xuyên nhất',
    type: SORT_TYPE.MOST_FREQUENTLY,
  ),
  SortType(
    icon: SvgIcon.sort_a_z,
    sortType: 'Sắp xếp theo bảng chữ cái',
    type: SORT_TYPE.SORT_BY_A_Z,
  ),
  SortType(
    icon: SvgIcon.clock,
    sortType: 'Tham gia gần đây',
    type: SORT_TYPE.RECENTLY,
  ),
];

class SortGroupMbs extends StatelessWidget {
  const SortGroupMbs({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.t;
    final SearchGroupController controller = Get.find<SearchGroupController>();
    return CustomMbs(
      height: 350,
      body: Column(
        children: [
          const Center(
            child: Text(
              'Sắp xếp nhóm',
              style: TextDefine.T1_B,
            ),
          ),
          Spaces.box16,
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final item = _sortType[index];
              return Container(
                padding: Spaces.h20v12,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset(item.icon),
                    Spaces.box14,
                    Text(
                      item.sortType,
                      style: TextDefine.T2_M,
                    ),
                    const Spacer(),
                    Obx(
                      () => SizedBox(
                        height: 17,
                        width: 17,
                        child: Radio<SORT_TYPE>(
                          activeColor: theme.secondary_02,
                          value: item.type,
                          groupValue: controller.selectedSortType.value,
                          onChanged: (value) =>
                              controller.onSelectedSortType(item.type),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) => const Divider(
              thickness: 1,
            ),
            itemCount: _sortType.length,
          )
        ],
      ),
    );
  }
}
