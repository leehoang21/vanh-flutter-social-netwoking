import 'package:commons/commons.dart';
import 'package:finplus/finplus/screens/home/home_controller.dart';
import 'package:finplus/utils/get_arguments_mixin.dart';

import '../../../models/group_info_data.dart';
import '../../../models/group_user_info_data.dart';

class GroupMemberManagementArgument {
  final List<GroupUserInfoData> listGroupMember;

  final RxGroupInfoData groupInfoData;

  GroupMemberManagementArgument({
    required this.listGroupMember,
    required this.groupInfoData,
  });
}

class GroupMemberManagementController extends GetxController
    with
        GetArguments<GroupMemberManagementArgument>,
        StateMixin<List<GroupUserInfoData>>,
        HomeControllerMinxin {
  late List<GroupUserInfoData> listGroupMember;

  late RxGroupInfoData groupInfoData;

  late final String position;

  @override
  void onInit() {
    listGroupMember = arguments!.listGroupMember;

    groupInfoData = arguments!.groupInfoData;

    super.onInit();
  }
}
