import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commons/commons.dart';
import 'package:finplus/finplus/screens/community/community_controller.dart';
import 'package:finplus/finplus/screens/community/new_feed/feed_view_container.dart';
import 'package:finplus/finplus/screens/home/home_controller.dart';
import 'package:finplus/routes/finplus_routes.dart';
import 'package:finplus/services/auth_service.dart';
import 'package:finplus/utils/styles.dart';
import 'package:finplus/widgets/avatar/avatar.dart';
import 'package:finplus/widgets/button/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Community extends StatelessWidget with HomeControllerMinxin {
  Community({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.t;
    final AuthService _auth = AuthService();
    final List<String> listCredentials = [];
    const storage = FlutterSecureStorage();

    return GetBuilder<CommunityController>(builder: (c) {
      return Scaffold(
        floatingActionButton: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Button(
              onPressed: () => Get.toNamed(Routes.chat_room),
              child: Text(
                'Chat room',
                style: TextDefine.P1_B.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            Spaces.boxH16,
            Button(
              onPressed: () {
                _auth.signOut();
                Get.offAndToNamed(Routes.login);
              },
              child: Text(
                'Đăng xuất',
                style: TextDefine.P1_B.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFFF6F7F8),
        body: CustomScrollView(
          slivers: [
            const SliverPadding(padding: EdgeInsets.only(top: 30)),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              sliver: SliverToBoxAdapter(
                child: Row(
                  children: [
                    const Avatar(value: ''),
                    Spaces.boxW10,
                    InkWell(
                      onTap: () => Get.toNamed(Routes.create_post),
                      child: Container(
                        padding: Spaces.h12v16,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                offset: const Offset(0, 1),
                                blurRadius: 5,
                                color: theme.secondary_01.withOpacity(0.5))
                          ],
                          borderRadius: Decorate.r24,
                        ),
                        child: Text(
                          'Bạn đang nghĩ gì?',
                          style:
                              TextDefine.P2_R.copyWith(color: theme.primary_01),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.only(left: 12, right: 12, bottom: 20),
              sliver: SliverToBoxAdapter(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () async {
                            await FirebaseFirestore.instance
                                .collection('credentials')
                                .get()
                                .then(
                                  (snapshot) => snapshot.docs.forEach(
                                    (element) {
                                      // ignore: iterable_contains_unrelated_type
                                      if (!listCredentials.contains(element))
                                        listCredentials.add(
                                          element['credential'],
                                        );
                                    },
                                  ),
                                );
                            print(listCredentials);
                          },
                          child: Text(
                            'Nhóm phổ biến',
                            style: TextDefine.T1_M.copyWith(
                                color: theme.primary_02,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.transparent,
                          ),
                          onPressed: () => Get.toNamed(Routes.search_group),
                          child: Text(
                            'Xem tất cả',
                            style: TextDefine.P3_R
                                .copyWith(color: theme.primary_04),
                          ),
                        ),
                      ],
                    ),
//                     Padding(
//                       padding: Spaces.h16,
//                       child: Button(
//                         type: ButtonType.gradient,
//                         onPressed: () async {
// //This returns a SigningResult
//                           final SigningResult result =
//                               await fido2.signChallenge(
//                             challenge:
//                                 '3820435cf5f79ca903a426a6e4497556fd387194c8af563627e893eb3614ad7c7b05f9e21ffa1e58b0544613cc974c5def3fbeb98d6fae60deb6f5d975744c10', // comes from your server
//                             allowCredentials:
//                                 listCredentials, //saved credentials for the user from your server
//                             userId:
//                                 '30', //the identifier for your user used during registration
//                             rpDomain:
//                                 'http://fido.local', // the domain name of your server (Relying Party)
//                             options: const AuthenticationOptions(
//                               useErrorDialogs:
//                                   true, // use error dialogs that are inbuilt
//                               biometricOnly:
//                                   true, //use only in-built biometric authenticator
//                             ),
//                           );
// //you can access and send this information on to your server for verification of the signed challenge.
//                           print(result.credentialId);
//                           print(result.signedChallenge);
//                           print(result.userId);
//                         },
//                         child: const Text('Login fido'),
//                       ),
//                     ),
                    // Padding(
                    //   padding: Spaces.h16,
                    //   child: Button(
                    //     type: ButtonType.gradient,
                    //     onPressed: () async {
                    //       await FirebaseFirestore.instance
                    //           .collection('credentials')
                    //           .get();
                    //       final RegistrationResult resultFido =
                    //           await fido2.register(
                    //         challenge: 'Hieu2',
                    //         rpDomain: 'http://fido.local',
                    //         userId: '30',
                    //       );
                    //       print(resultFido.credentialId.toString());

                    //       print(resultFido.signedChallenge.toString());

                    //       print(resultFido.publicKey.toString());
                    //     },
                    //     child: const Text('Đăng ký'),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.only(
                  left: 12, right: 12, bottom: 10, top: 22),
              sliver: SliverToBoxAdapter(
                child: InkWell(
                  onTap: c.onRefresh,
                  child: Text(
                    'Refresh',
                    style: TextDefine.T1_M.copyWith(
                        color: theme.primary_02, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.only(
                  left: 12, right: 12, bottom: 10, top: 22),
              sliver: SliverToBoxAdapter(
                child: InkWell(
                  onTap: () async {
                    print('object');
                    for (final String e in listCredentials) {
                      final cre = await storage.read(key: e);
                      print(cre);
                    }
                    print('object');
                  },
                  child: Text(
                    'News Feed',
                    style: TextDefine.T1_M.copyWith(
                        color: theme.primary_02, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
            Obx(
              () => SliverToBoxAdapter(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: c.listPost.value.length,
                  itemBuilder: (context, index) {
                    final post = c.listPost.value[index];
                    return FeedViewContainer(
                      name: post.name,
                      uid: post.uid,
                      content: post.content,
                      timestamp: post.time,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
