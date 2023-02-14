import 'package:commons/commons.dart';
import 'package:finplus/finplus/screens/community/search_group/search_group_controller.dart';
import 'package:finplus/utils/styles.dart';
import 'package:finplus/widgets/custom_mbs/custom_mbs.dart';
import 'package:flutter/material.dart';

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
              final item = controller.getSortType(index);
              return InkWell(
                onTap: () {
                  controller.onSelectedSortType(item.type);
                },
                child: Container(
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
                            onChanged: (value) {},
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => const Divider(
              thickness: 1,
            ),
            itemCount: controller.sortTypeLength,
          )
        ],
      ),
    );
  }
}
