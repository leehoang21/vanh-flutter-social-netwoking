import 'package:finplus/utils/styles.dart';
import 'package:finplus/widgets/avatar/avatar.dart';
import 'package:finplus/widgets/show_text_more/show_text_more.dart';
import 'package:flutter/material.dart';

class FeedViewContainer extends StatelessWidget {
  final String name;
  final String uid;
  final String content;
  final String timestamp;

  const FeedViewContainer({
    super.key,
    required this.name,
    required this.uid,
    required this.content,
    required this.timestamp,
  });
  @override
  Widget build(BuildContext context) {
    final theme = context.t;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Container(
        padding: Spaces.a10,
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
              offset: const Offset(2, 0),
              blurRadius: 5,
              color: theme.primary_01.withOpacity(0.5))
        ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12, top: 12, right: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Avatar(value: ''),
                      Spaces.box12,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: TextDefine.P4_B,
                          ),
                          Spaces.box4,
                          Text(
                            timestamp,
                            style: const TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Spaces.box14,
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: ShowMoreText(
                content: content,
                showMoreLength: 100,
                contentStyle: TextDefine.P2_R,
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
          ],
        ),
      ),
    );
  }
}
