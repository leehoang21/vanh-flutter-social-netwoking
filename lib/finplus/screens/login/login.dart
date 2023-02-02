import 'package:carousel_slider/carousel_slider.dart';
import 'package:commons/commons.dart';
import 'package:finplus/providers/auth_provider.dart';
import 'package:finplus/utils/styles.dart';
import 'package:finplus/utils/svg.dart';
import 'package:flutter/material.dart';

import '/widgets/button/button.dart';
import '/widgets/text_input/text_input.dart';
import '../community/create_post_screen/create_post_screen.dart';
import 'login_controller.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.t;
    final Size size = MediaQuery.of(context).size;

    return GetBuilder<LoginController>(
      builder: (c) => Stack(
        children: [
          Container(
            color: theme.primary_01,
            width: size.width,
            height: size.height,
            child: Image.asset(
              Picture.login_background,
              fit: BoxFit.cover,
            ),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            body: ListView(
              physics: const ClampingScrollPhysics(),
              padding: EdgeInsets.zero,
              children: [
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(bottom: Radius.circular(25)),
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        const SafeArea(child: SizedBox()),
                        Stack(
                          children: [
                            CarouselSlider.builder(
                              itemCount: 3,
                              itemBuilder: (_, i, __) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 50),
                                child: Column(
                                  children: [
                                    Spaces.box24,
                                    SvgPicture.asset(SvgIcon.discover_icon),
                                    Spaces.box32,
                                    Text('Discover course',
                                        style: TextDefine.T1_B
                                            .copyWith(color: Colors.green)),
                                    const Text(
                                      'Udemy is an online learning and teaching marketplace with over 204,000 courses and more.',
                                      textAlign: TextAlign.center,
                                    )
                                  ],
                                ),
                              ),
                              options: CarouselOptions(
                                height: 235,
                                autoPlay: true,
                                viewportFraction: 1,
                                onPageChanged: (index, reason) {},
                                autoPlayInterval: const Duration(seconds: 3),
                              ),
                            ),
                            IconButton(
                              onPressed: Get.back,
                              icon: const Icon(Icons.arrow_back),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Spaces.box42,
                Text(
                  'Đăng nhập',
                  style: TextDefine.H1_B.copyWith(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                Spaces.box24,
                Padding(
                  padding: Spaces.h16,
                  child: TextInput(controller: c.username),
                ),
                Spaces.box16,
                Padding(
                  padding: Spaces.h16,
                  child: TextInput(controller: c.password),
                ),
                Spaces.box16,
                Padding(
                  padding: Spaces.h16,
                  child: Button(
                    type: ButtonType.gradient,
                    onPressed: () => Get.to(
                       CreatePostScreen(),
                    ),
                    child: const Text('Đăng nhập'),
                  ),
                ),
                Spaces.box16,
                IconButton(
                  onPressed: () => c.login(LoginType.facebook),
                  icon: SvgPicture.asset(SvgIcon.fb_icon),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
