import 'package:commons/commons.dart';
import 'package:finplus/finplus/screens/group_setting/privacy_mbs/privacy_mbs.dart';
import 'package:finplus/utils/get_arguments_mixin.dart';
import 'package:flutter/cupertino.dart';

import '../../../models/group_info_data.dart';

enum UpsertKind { ADD, EDIT }

class UpsertGroupArgument {
  final UpsertKind kind;

  final RxGroupInfoData groupInfoData;

  UpsertGroupArgument({
    required this.kind,
    required this.groupInfoData,
  });
}

class UpsertGroupController extends GetxController
    with GetArguments<UpsertGroupArgument> {
  late final Rx<GroupInfoData?> groupInfoData;

  late final TextEditingController groupName;

  late final TextEditingController aboutGroup;

  late final TextEditingController groupRule;

  late final UpsertKind kind;

  late final Rx<GROUP_PRIVACY> selectedGroupPrivacy;

  @override
  void onInit() {
    kind = arguments?.kind ?? UpsertKind.ADD;

    groupInfoData = arguments?.groupInfoData ?? Rx(null);

    groupName = TextEditingController(text: groupInfoData.value?.name);

    aboutGroup = TextEditingController(text: groupInfoData.value?.about);

    groupRule = TextEditingController(text: groupInfoData.value?.rule);

    selectedGroupPrivacy =
        Rx(groupInfoData.value?.privacy ?? GROUP_PRIVACY.PUBLIC);

    super.onInit();
  }

  void getGroupPrivacy() {
    Get.bottomSheet(
      PrivacyMbs(
        typeName: 'Quyền riêng tư',
        selectedGroupPrivacy: selectedGroupPrivacy,
        fn: setGroupPrivacy,
      ),
    );
    groupInfoData.value!.privacy = selectedGroupPrivacy.value;
  }

  void setGroupPrivacy(GROUP_PRIVACY selectedGroupPrivacy) {
    groupInfoData.update((val) {
      val!.privacy = selectedGroupPrivacy;
    });
  }

  @override
  void onClose() {
    groupName.dispose();
    aboutGroup.dispose();
  }
}
