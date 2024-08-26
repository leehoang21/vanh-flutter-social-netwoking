import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commons/commons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../models/group_info_data.dart';
import '../../../models/group_user_info_data.dart';
import '../../../models/post_model.dart';
import '../../../utils/get_arguments_mixin.dart';
import '../../../utils/utils.dart';

// ignore: camel_case_types
enum GROUP_INTERACT {
  JOIN,
  LEAVE,
  FOLLOW,
  UNFOLLOW,
}

class GroupArgument {
  final RxGroupInfoData groupInfoData;

  GroupArgument({
    required this.groupInfoData,
  });
}

class GroupController extends GetxController
    with GetArguments<GroupArgument>, StateMixin<List<GroupUserInfoData>> {
  late final RxString image;

  late final RxGroupInfoData groupInfoData;

  late List<GroupUserInfoData> listGroupMember;

  late int limitAvatarDisplay;

  late final Rx<List<PostModel>> listPost;

  late final RefreshController refreshController;

  @override
  void onInit() {
    if (arguments != null) {
      groupInfoData = arguments!.groupInfoData;
    } else {
      groupInfoData = RxGroupInfoData(GroupInfoData(
          id: 1, privacy: GROUP_PRIVACY.PUBLIC, createdBy: 1, createdAt: 1));
    }

    listGroupMember = [];

    image = ''.obs;

    refreshController = RefreshController();

    listPost = Rx([]);

    getFeed();

    super.onInit();
  }

  Future<void> pickImage() async {
    final imagePath = await Utils.pickImage(ImageSource.gallery);
    if (imagePath != null) {
      image.value = imagePath;
    }
  }

  Future getFeed() async {
    await FirebaseFirestore.instance.collection('postInGroup').get().then(
          (snapshot) => snapshot.docs.forEach(
            (element) {
              listPost.update(
                (val) {
                  val!.add(
                    PostModel(
                      name: element['name'],
                      uid: element['uid'],
                      content: element['content'],
                      time: element['time'],
                    ),
                  );
                },
              );
            },
          ),
        );
  }

  void onRefresh() {
    listPost.value = [];

    getFeed();
  }

  @override
  void onClose() {
    refreshController.dispose();
    super.onClose();
  }
}
