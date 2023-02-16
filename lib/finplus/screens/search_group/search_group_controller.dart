import 'package:commons/commons.dart';

import '../../../utils/svg.dart';

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

class SearchGroupController extends GetxController {
  late final Rx<SORT_TYPE> selectedSortType;

  late final int sortTypeLength;

  @override
  void onInit() {
    selectedSortType = Rx(SORT_TYPE.MOST_FREQUENTLY);
    sortTypeLength = _sortType.length;
    super.onInit();
  }

  SortType getSortType(int index) {
    return _sortType[index];
  }

  void onSelectedSortType(SORT_TYPE type) {
    selectedSortType.value = type;
  }
}
