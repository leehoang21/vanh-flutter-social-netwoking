import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commons/commons.dart';
import 'package:finplus/finplus/screens/create_post/create_post_controller.dart';
import 'package:finplus/models/post_model.dart';
import 'package:finplus/services/database.dart';
import 'package:flutter/material.dart';

import '../../../services/auth_service.dart';
import '../../../utils/styles.dart';
import '../../../utils/svg.dart';
import '../../../widgets/avatar/avatar.dart';

class CreatePost extends StatelessWidget {
  const CreatePost({super.key, this.inHome = true});
  final bool inHome;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreatePostController>(
      init: CreatePostController(),
      builder: (controller) {
        final theme = context.t;
        final AuthService _auth = AuthService();
        return Scaffold(
          extendBody: true,
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        child: SvgPicture.asset(
                          SvgIcon.close,
                          height: 15,
                          color: theme.primary_01,
                        ),
                        onTap: Get.back,
                      ),
                      Text('Create a post',
                          style: TextDefine.T1_M
                              .copyWith(color: theme.primary_01)),
                      Obx(
                        () {
                          return InkWell(
                            onTap: () async {
                              if (inHome) {
                                await DatabaseService(uid: _auth.user!.uid)
                                    .post(
                                  PostModel(
                                    name: controller.name.value,
                                    uid: _auth.user!.uid,
                                    content: controller.content.value.text,
                                    time: DateTime.now().toString(),
                                  ),
                                );
                                Get.back();
                              } else {
                                await DatabaseService(uid: _auth.user!.uid)
                                    .postInGroup(
                                  PostModel(
                                    name: controller.name.value,
                                    uid: _auth.user!.uid,
                                    content: controller.content.value.text,
                                    time: DateTime.now().toString(),
                                  ),
                                );
                                Get.back();
                              }
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: 50,
                              height: 30,
                              decoration: BoxDecoration(
                                color: controller.enablePost.value
                                    ? const Color(0xFF17AB37)
                                    : Colors.grey.withOpacity(0.5),
                              ),
                              child: const Text(
                                'Post',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const Divider(
                  height: 0,
                  thickness: 1,
                  color: Color(0xFFD9D9D9),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: Spaces.h16v12,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 4,
                                ),
                                child: const Avatar(value: ''),
                              ),
                              Spaces.box10,
                              SizedBox(
                                height: 30,
                                width: 100,
                                child: StreamBuilder(
                                  stream: FirebaseFirestore.instance
                                      .collection('user')
                                      .where('uid', isEqualTo: _auth.user!.uid)
                                      .snapshots(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot snapshot) {
                                    if (snapshot.hasData) {
                                      if (snapshot.data.docs[0]['name'] != '')
                                        controller.name.value =
                                            snapshot.data.docs[0]['name'];
                                    }
                                    return Text(
                                      controller.name.value,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          child: TextField(
                            controller: controller.content,
                            scrollPhysics: const NeverScrollableScrollPhysics(),
                            keyboardType: TextInputType.text,
                            focusNode: controller.focusNode,
                            maxLines: null,
                            maxLength: 2000,
                            inputFormatters: const [],
                            decoration: const InputDecoration(
                              hintText: 'Bạn đang nghĩ gì?',
                              fillColor: Colors.white,
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                            ),
                          ),
                        ),
                        Spaces.box42,
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
