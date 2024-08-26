import 'package:commons/commons.dart';
import 'package:finplus/finplus/screens/group_setting/post_permission_mbs.dart/post_permission_mbs.dart';
import 'package:finplus/finplus/screens/group_setting/privacy_mbs/privacy_mbs.dart';
import 'package:finplus/finplus/screens/upsert_group/upsert_group_controller.dart';
import 'package:finplus/routes/finplus_routes.dart';
import 'package:finplus/utils/get_arguments_mixin.dart';

import '../../../models/group_info_data.dart';

class SettingType {
  final String title;
  final RxString? type;
  final Function()? fn;

  const SettingType({
    required this.title,
    this.type,
    this.fn,
  });
}

class GroupSettingArgument {
  final RxGroupInfoData groupInfoData;

  GroupSettingArgument({
    required this.groupInfoData,
  });
}

class GroupSettingController extends GetxController
    with GetArguments<GroupSettingArgument> {
  late final RxGroupInfoData groupInfoData;

  late final Rx<GROUP_PRIVACY> selectedGroupPrivacy;

  late final RxString groupPrivacyType;

  late final Rx<POST_PERMISSION> selectedPostPermission;

  late final RxString postPermissionType;

  @override
  void onInit() {
    if (arguments != null) {
      groupInfoData = arguments!.groupInfoData;
    } else {
      groupInfoData = RxGroupInfoData(GroupInfoData(
          id: 1, privacy: GROUP_PRIVACY.PUBLIC, createdBy: 1, createdAt: 1));
    }
    selectedGroupPrivacy = groupInfoData.privacy.obs;
    groupPrivacyType = groupInfoData.value.privacy.title.obs;
    selectedPostPermission = POST_PERMISSION.EVERYONE.obs;
    postPermissionType = selectedPostPermission.value.title.obs;
    super.onInit();
  }

  SettingType getGroupSetting(int index) {
    return _groupSetting[index];
  }

  SettingType getManagePostSetting(int index) {
    return _managePostSetting[index];
  }

  void getGroupPrivacy() {
    Get.bottomSheet(
      PrivacyMbs(
        typeName: 'Quyền riêng tư',
        selectedGroupPrivacy: selectedGroupPrivacy,
        fn: setGroupPrivacy,
      ),
    ).then(
      (value) {},
    );
  }

  void setGroupPrivacy(GROUP_PRIVACY selectedGroupPrivacy) {
    groupPrivacyType.value = selectedGroupPrivacy.title;
    groupInfoData.update((val) {
      val!.privacy = selectedGroupPrivacy;
    });
  }

  void getPostPermission() {
    Get.bottomSheet(
      PostPermissionMbs(
        typeName: 'Ai có thể đăng',
        selectedPostPermission: selectedPostPermission,
        fn: setPostPermission,
      ),
    );
  }

  void setPostPermission(POST_PERMISSION selectedPostPermission) {
    postPermissionType.value = selectedPostPermission.title;
  }

  late final List<SettingType> _groupSetting = [
    SettingType(
      title: 'Tên và mô tả',
      fn: () => Get.toNamed(
        Routes.upsert_group,
        arguments: UpsertGroupArgument(
          kind: UpsertKind.EDIT,
          groupInfoData: groupInfoData,
        ),
      ),
    ),
    const SettingType(
      title: 'Ảnh bìa',
    ),
    SettingType(
      title: 'Quyền riêng tư',
      type: groupPrivacyType,
      fn: getGroupPrivacy,
    ),
  ];

  late final List<SettingType> _managePostSetting = [
    SettingType(
      title: 'Ai có thể đăng',
      type: postPermissionType,
      fn: getPostPermission,
    ),
    SettingType(
      title: 'Phê duyệt mọi bài viết của thành viên',
      type: 'Đang bật'.obs,
    ),
    SettingType(
      title: 'Phê duyệt nội dung chỉnh sửa',
      type: 'Tắt'.obs,
    ),
    SettingType(
      title: 'Đăng ẩn danh',
      type: 'Tắt'.obs,
    ),
  ];
}
