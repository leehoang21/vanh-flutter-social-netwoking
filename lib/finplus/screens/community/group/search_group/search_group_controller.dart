import 'package:commons/commons.dart';
import 'package:finplus/finplus/screens/community/group/search_group/sort_group_mbs/sort_group_mbs.dart';

class SearchGroupController extends GetxController {
  late final Rx<SORT_TYPE> selectedSortType;

  @override
  void onInit() {
    selectedSortType = Rx(SORT_TYPE.MOST_FREQUENTLY);
    super.onInit();
  }
    void onSelectedSortType(SORT_TYPE type) {
    selectedSortType.value = type;
  }
}
