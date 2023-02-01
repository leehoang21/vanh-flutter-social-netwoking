import 'package:commons/commons.dart';
import 'package:finplus/utils/styles.dart';
import 'package:finplus/utils/svg.dart';
import 'package:flutter/material.dart';

class CommunityNewFeedScreen extends StatelessWidget {
  const CommunityNewFeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: 1,
        (context, index) => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(
              0xffFFFFFF,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 12, top: 12, right: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.asset(
                            SvgIcon.avatar_icon,
                            width: 38,
                            height: 38,
                            fit: BoxFit.fill,
                          ),
                        ),
                        Spaces.box12,
                        Column(
                          children: const [
                            Text(
                              'Link Ka',
                              style: TextDefine.P4_B,
                            ),
                            Spaces.box4,
                            Text(
                              '3 giờ trước',
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SvgPicture.asset(SvgIcon.ellipsis_icon),
                  ],
                ),
              ),
              Spaces.box14,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Wrap(
                  spacing: 6.0,
                  runSpacing: 4.0,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xffD9D9D9),
                      ),
                      child: const Padding(
                        padding: Spaces.h4v6,
                        child: Text(
                          'MBB',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 9,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xffD9D9D9),
                      ),
                      child: const Padding(
                        padding: Spaces.h4v6,
                        child: Text(
                          'SHS',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 9,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xffD9D9D9),
                      ),
                      child: const Padding(
                        padding: Spaces.h4v6,
                        child: Text(
                          'VIC',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 9,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text.rich(
                  TextSpan(
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 10,
                    ),
                    children: [
                      TextSpan(
                          text:
                              'Ngân hàng TMCP Quân Đội (HOSE: MBB) đạt hạn mức tăng trưởng tín  dụng cao thứ 3 toàn ngành năm 2022: Nhờ tỷ lệ an toàn vốn (CAR) ở  mức 12%, LDR ở mức 78% vào cuối Q3/22, theo ước tính của chúng....'),
                      TextSpan(
                        text: 'thêm',
                        style: TextStyle(
                          color: Color(0xff7A8599),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                child: Image.asset(
                  Picture.popular_group,
                  fit: BoxFit.cover,
                ),
                width: double.maxFinite,
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Wrap(
                      spacing: -6,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.asset(
                            SvgIcon.avatar_icon,
                            width: 22,
                            height: 22,
                            fit: BoxFit.fill,
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.asset(
                            SvgIcon.avatar_icon,
                            width: 22,
                            height: 22,
                            fit: BoxFit.fill,
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.asset(
                            SvgIcon.avatar_icon,
                            width: 22,
                            height: 22,
                            fit: BoxFit.fill,
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: SvgPicture.asset(
                            SvgIcon.more_like_icon,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          '1.000 Like',
                          style: TextDefine.P4_R
                              .copyWith(color: const Color(0xff7A8599)),
                        ),
                        Spaces.box6,
                        Text(
                          '10 Comment',
                          style: TextDefine.P4_R
                              .copyWith(color: const Color(0xff7A8599)),
                        ),
                        Spaces.box6,
                        Text(
                          '1 Share',
                          style: TextDefine.P4_R
                              .copyWith(color: const Color(0xff7A8599)),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const Divider(
                indent: 12,
                endIndent: 12,
                height: 1,
                thickness: 1,
                color: Color(0xffD3DAE5),
              ),
              Spaces.box10,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          SvgIcon.like_icon,
                        ),
                        Spaces.box4,
                        const Text(
                          'Like',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff4E5D78),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Text(
                          'Comment',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff4E5D78),
                          ),
                        ),
                        Spaces.box4,
                        SvgPicture.asset(SvgIcon.comment_icon),
                      ],
                    ),
                    Row(
                      children: [
                        const Text('Share',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff4E5D78),
                            )),
                        Spaces.box4,
                        SvgPicture.asset(SvgIcon.share_icon),
                      ],
                    ),
                  ],
                ),
              ),
              Spaces.box14,
              const Divider(
                indent: 12,
                endIndent: 12,
                height: 1,
                thickness: 1,
                color: Color(0xffD3DAE5),
              ),
              Spaces.box10,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        SvgIcon.avatar_icon,
                        width: 38,
                        height: 38,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Spaces.box8,
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xffF6F7F8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text('John'),
                            Text.rich(
                              TextSpan(
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 10,
                                ),
                                children: [
                                  TextSpan(
                                      text:
                                          'Các nguồn năng lượng tái tạo, chẳng hạn như....'),
                                  TextSpan(
                                    text: 'thêm',
                                    style: TextStyle(
                                      color: Color(0xff7A8599),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
