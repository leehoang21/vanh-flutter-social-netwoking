import 'package:expandable/expandable.dart';
import 'package:finplus/utils/styles.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ShowMoreText extends StatefulWidget {
  final int showMoreLength;
  final String content;
  final TextStyle? contentStyle;
  final TextStyle? buttonStyle;
  const ShowMoreText(
      {Key? key,
      this.showMoreLength = 250,
      required this.content,
      this.contentStyle,
      this.buttonStyle})
      : super(key: key);

  @override
  State<ShowMoreText> createState() => _ShowMoreTextState();
}

class _ShowMoreTextState extends State<ShowMoreText> {
  final ExpandableController controller = ExpandableController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.t;
    return ExpandableNotifier(
      controller: controller,
      child: ScrollOnExpand(
        child: Expandable(
          theme: const ExpandableThemeData(hasIcon: false),
          collapsed: Text.rich(TextSpan(
              text: widget.content.length > widget.showMoreLength
                  ? '${widget.content.substring(0, widget.showMoreLength)}...'
                  : widget.content,
              style: widget.contentStyle,
              children: [
                if (widget.content.length > widget.showMoreLength)
                  TextSpan(
                      text: 'xem thêm',
                      style: widget.buttonStyle ??
                          TextDefine.P3_R.copyWith(color: theme.primary_03),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => controller.toggle())
              ])),
          expanded: Text.rich(TextSpan(
              text: widget.content,
              style: widget.contentStyle,
              children: [
                TextSpan(
                    text: ' thu gọn',
                    style: widget.buttonStyle ??
                        TextDefine.P3_R.copyWith(color: theme.primary_03),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => controller.toggle())
              ])),
        ),
      ),
    );
  }
}
