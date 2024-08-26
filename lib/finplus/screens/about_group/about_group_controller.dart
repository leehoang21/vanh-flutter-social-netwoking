import 'package:commons/commons.dart';

import '../../../models/group_info_data.dart';
import '../../../models/group_user_info_data.dart';
import '../../../utils/get_arguments_mixin.dart';

class AboutGroupArgument {
  final RxGroupInfoData groupInfoData;

  final List<GroupUserInfoData> listGroupMember;

  AboutGroupArgument({
    required this.groupInfoData,
    required this.listGroupMember,
  });
}

class AboutGroupController extends GetxController
    with GetArguments<AboutGroupArgument> {
  late final RxGroupInfoData groupInfoData;

  late List<GroupUserInfoData> listGroupMember;

  late int limitAvatarDisplay;

  List<GroupUser> get listAdminGroup =>
      groupInfoData.groupUsers.where((e) => e.role == 'ADMIN').toList();

  @override
  void onInit() {
    if (arguments != null) {
      groupInfoData = arguments!.groupInfoData;
      listGroupMember = arguments!.listGroupMember;
    } else {
      groupInfoData = RxGroupInfoData(GroupInfoData(
          id: 1, privacy: GROUP_PRIVACY.PUBLIC, createdBy: 1, createdAt: 1));
    }
    listGroupMember = [];
    super.onInit();
  }

  int get getLimitAvatarDisplay =>
      listGroupMember.length < 6 ? listGroupMember.length : 6;

  @override
  void onReady() {}
}
