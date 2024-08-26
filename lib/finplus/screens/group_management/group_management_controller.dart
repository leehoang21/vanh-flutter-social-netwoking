import 'package:commons/commons.dart';
import 'package:finplus/utils/get_arguments_mixin.dart';

import '../../../models/group_info_data.dart';
import '../../../utils/svg.dart';

class GroupManagementArgument {
  final RxGroupInfoData groupInfoData;

  GroupManagementArgument({
    required this.groupInfoData,
  });
}

class GroupManagementController extends GetxController
    with GetArguments<GroupManagementArgument> {
  late RxGroupInfoData groupInfoData;

  @override
  void onInit() {
    if (arguments != null) {
      groupInfoData = arguments!.groupInfoData;
    }
    super.onInit();
  }

  ManageGroupType getManageGroupType(int index) {
    return _manageGroupType[index];
  }
}

class ManageGroupType {
  final String icon;
  final String type;
  final String remaining;

  const ManageGroupType({
    required this.icon,
    required this.type,
    required this.remaining,
  });
}

const _manageGroupType = [
  ManageGroupType(
    icon: SvgIcon.reported_post,
    type: 'Bài viết bị báo cáo',
    remaining: 'bài viết',
  ),
  ManageGroupType(
    icon: SvgIcon.post_approve,
    type: 'Bài viết đang chờ phê duyệt',
    remaining: 'bài viết',
  ),
  ManageGroupType(
    icon: SvgIcon.member_approve,
    type: 'Yêu cầu làm thành viên',
    remaining: 'thành viên',
  ),
];
