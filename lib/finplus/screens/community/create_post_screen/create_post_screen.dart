import 'package:commons/commons.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

import '../../../../utils/styles.dart';
import '../../../../utils/svg.dart';

class CreatePostScreen extends StatelessWidget {
  CreatePostScreen({super.key});
  final FocusNode _nodeText = FocusNode();

  KeyboardActionsConfig _buildConfig(BuildContext context) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
      keyboardBarColor: Colors.grey[200],
      nextFocus: true,
      actions: [
        KeyboardActionsItem(
          displayArrows: false,
          toolbarAlignment: MainAxisAlignment.start,
          focusNode: _nodeText,
          toolbarButtons: [
            (node) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Spaces.box24,
                  InkWell(
                    child: SizedBox(
                      width: 22,
                      height: 22,
                      child: SvgPicture.asset(SvgIcon.add_circle),
                    ),
                    onTap: () {},
                  ),
                  Spaces.box16,
                  InkWell(
                    child: SizedBox(
                      width: 22,
                      height: 22,
                      child: SvgPicture.asset(SvgIcon.choose_stocks),
                    ),
                    onTap: () {},
                  ),
                  Spaces.box16,
                  InkWell(
                    child: SizedBox(
                      width: 22,
                      height: 22,
                      child: SvgPicture.asset(SvgIcon.emojis),
                    ),
                    onTap: () {},
                  ),
                  Spaces.box16,
                  InkWell(
                    child: SizedBox(
                      width: 22,
                      height: 22,
                      child: SvgPicture.asset(SvgIcon.image),
                    ),
                    onTap: () {},
                  ),
                  Spaces.box16,
                  InkWell(
                    child: SizedBox(
                      width: 22,
                      height: 22,
                      child: SvgPicture.asset(SvgIcon.camera),
                    ),
                    onTap: () {},
                  ),
                ],
              );
            },
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      backgroundColor: Colors.white,
      body: SizedBox(
        height: double.infinity,
        child: ListView(
          shrinkWrap: true,
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 9,
                        width: 48,
                        child: InkWell(
                          child: SvgPicture.asset(
                            SvgIcon.close,
                          ),
                          onTap: () => Get.back(),
                        ),
                      ),
                      const Text(
                        'Create a post',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Container(
                        height: 24,
                        width: 48,
                        padding: Spaces.h10v6,
                        decoration: const BoxDecoration(
                          color: Color(0xFF17AB37),
                          borderRadius: BorderRadius.all(
                            Radius.circular(3),
                          ),
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
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 1,
                  color: const Color(0xFFD9D9D9),
                ),
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
                        width: 38,
                        height: 38,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            Picture.avatar_example,
                          ),
                        ),
                      ),
                      Spaces.box10,
                      const Text(
                        'Trần Thuỳ Linh',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
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
                  child: SizedBox(
                    height: 500,
                    child: KeyboardActions(
                      config: _buildConfig(context),
                      child: TextField(
                        keyboardType: TextInputType.text,
                        focusNode: _nodeText,
                        maxLines: null,
                        maxLength: 2000,
                        decoration: const InputDecoration(
                          hintText:
                              'Write something...\n@ to mention someone else',
                          fillColor: Colors.white,
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
