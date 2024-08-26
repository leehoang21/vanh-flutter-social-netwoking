import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commons/commons.dart';
import 'package:finplus/finplus/screens/home/home_controller.dart';
import 'package:finplus/models/post_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CommunityController extends GetxController with HomeControllerMinxin {
  late final RefreshController refreshController;

  late final int groupId;

  late final TextEditingController name;

  late final TextEditingController age;

  late Stream<QuerySnapshot<Map<String, dynamic>>> snapshots;

  final database = FirebaseFirestore.instance;

  late final Rx<List<PostModel>> listPost;

  @override
  void onInit() {
    refreshController = RefreshController();

    name = TextEditingController(text: 'Hieu');

    age = TextEditingController(text: '22');

    listPost = Rx([]);

    getFeed();

    super.onInit();
  }

  Future getFeed() async {
    await FirebaseFirestore.instance.collection('post').get().then(
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

    name.dispose();

    age.dispose();
    super.onClose();
  }
}
