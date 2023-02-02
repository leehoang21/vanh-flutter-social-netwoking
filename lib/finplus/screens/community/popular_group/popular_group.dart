import 'package:finplus/utils/styles.dart';
import 'package:flutter/material.dart';

class PopularGroup extends StatelessWidget {
  const PopularGroup({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      sliver: SliverToBoxAdapter(
        child: SizedBox(
          height: 100,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              Stack(
                children: [
                  const Placeholder(
                    fallbackHeight: 100,
                    fallbackWidth: 110,
                  ),
                  Container(
                    height: 100,
                    width: 110,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12,
                            ),
                            child: Text(
                              'Tự học chứng khoán cho người mới bắt đầu',
                              style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.green,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 7,
                                  vertical: 3,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: const [
                                    Icon(
                                      Icons.group_add,
                                      size: 10,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      'Join',
                                      style: TextStyle(
                                        color: Color(0xFFFFFFFF),
                                        fontSize: 8,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Spaces.box12,
              Stack(
                children: [
                  const Placeholder(
                    fallbackHeight: 100,
                    fallbackWidth: 110,
                  ),
                  Container(
                    height: 100,
                    width: 110,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12,
                            ),
                            child: Text(
                              'Tự học chứng khoán cho người mới bắt đầu',
                              style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0xffEDFEF1),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 7,
                                  vertical: 3,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: const [
                                    Icon(
                                      Icons.near_me,
                                      color: Color(0xff17AB37),
                                      size: 10,
                                    ),
                                    Text(
                                      'Send',
                                      style: TextStyle(
                                        color: Color(0xff14C53B),
                                        fontSize: 8,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Spaces.box12,
              Stack(
                children: [
                  const Placeholder(
                    fallbackHeight: 100,
                    fallbackWidth: 110,
                  ),
                  Container(
                    height: 100,
                    width: 110,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12,
                            ),
                            child: Text(
                              'Tự học chứng khoán cho người mới bắt đầu',
                              style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.green,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 7,
                                  vertical: 3,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: const [
                                    Icon(
                                      Icons.groups,
                                      color: Colors.white,
                                      size: 10,
                                    ),
                                    Text(
                                      'Joined',
                                      style: TextStyle(
                                        color: Color(0xFFFFFFFF),
                                        fontSize: 7,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
