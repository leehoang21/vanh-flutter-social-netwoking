import 'package:commons/commons.dart';
import 'package:finplus/utils/styles.dart';
import 'package:flutter/material.dart';

import '../../../../utils/svg.dart';

class CreatePostMbs extends StatelessWidget {
  const CreatePostMbs({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.375,
      padding: const EdgeInsets.fromLTRB(32, 8, 32, 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(39),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF8E8C8C),
            blurRadius: 2,
            
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            height: 3,
            width: 38,
            color: const Color(0xFFD9D9D9),
          ),
          Spaces.box24,
          InkWell(
            child: Row(
              children: [
                SizedBox(
                  width: 22,
                  height: 22,
                  child: SvgPicture.asset(SvgIcon.camera),
                ),
                Spaces.box24,
                const Text(
                  'Camera',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            onTap: () {},
          ),
          Spaces.box20,
          InkWell(
            child: Row(
              children: [
                SizedBox(
                  width: 22,
                  height: 22,
                  child: SvgPicture.asset(SvgIcon.image),
                ),
                Spaces.box24,
                const Text(
                  'Image',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            onTap: () {},
          ),
          Spaces.box20,
          InkWell(
            child: Row(
              children: [
                SizedBox(
                  width: 22,
                  height: 22,
                  child: SvgPicture.asset(SvgIcon.emojis),
                ),
                Spaces.box24,
                const Text(
                  'Emojis',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            onTap: () {},
          ),
          Spaces.box20,
          InkWell(
            child: Row(
              children: [
                SizedBox(
                  width: 22,
                  height: 22,
                  child: SvgPicture.asset(SvgIcon.choose_stocks),
                ),
                Spaces.box24,
                const Text(
                  'Choose stocks',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            onTap: () {},
          ),
          Spaces.box20,
        ],
      ),
    );
  }
}
