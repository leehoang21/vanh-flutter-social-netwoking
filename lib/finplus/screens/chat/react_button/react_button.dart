import 'package:finplus/utils/styles.dart';
import 'package:finplus/utils/svg.dart';
import 'package:finplus/widgets/custom_tooltip/custom_tooltip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class _ReactItem {
  final String reaction;
  final int value;

  const _ReactItem({required this.reaction, required this.value});
}

const reactList = [
  _ReactItem(reaction: SvgIcon.cool_icon, value: 0),
  _ReactItem(reaction: SvgIcon.sleep_icon, value: 1),
  _ReactItem(reaction: SvgIcon.angry_icon, value: 2),
  _ReactItem(reaction: SvgIcon.love_icon, value: 3),
  _ReactItem(reaction: SvgIcon.fun_icon, value: 4),
];

class ReactButton extends StatefulWidget {
  final void Function(int reactIndex) onReact;
  //active when onLongPress is enable
  final VoidCallback? onPressed;
  final bool enable;
  final Widget icon;
  final bool enableLongPress;
  final num? dimension;
  final EdgeInsetsGeometry padding;
  const ReactButton(
      {Key? key,
      required this.onReact,
      required this.icon,
      this.dimension,
      this.onPressed,
      this.enableLongPress = false,
      this.padding = const EdgeInsets.all(4),
      this.enable = true})
      : super(key: key);

  @override
  State<ReactButton> createState() => _ReactButtonState();
}

class _ReactButtonState extends State<ReactButton>
    with TickerProviderStateMixin {
  late final CustomToolTipController controller;
  late final AnimationController _controller;
  late final Animation<double> _animation;
  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    );
    controller = CustomToolTipController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.t;
    return CustomToolTip(
        barrierDismissible: true,
        barrierColor: Colors.black12,
        controller: controller,
        child: SizedBox.square(
          dimension: widget.dimension?.toDouble(),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: IgnorePointer(
              ignoring: !widget.enable,
              child: InkWell(
                  onTap: !widget.enableLongPress
                      ? _onPressedButton
                      : widget.onPressed,
                  onLongPress: widget.enableLongPress ? _onPressedButton : null,
                  child: Padding(
                    padding: widget.padding,
                    child: widget.icon,
                  )),
            ),
          ),
        ),
        direction: TooltipDirection.top,
        fitScreen: true,
        tooltip: SizeTransition(
          sizeFactor: _animation,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: Spaces.h16,
                alignment: Alignment.center,
                child: Container(
                  padding: Spaces.a8,
                  decoration: BoxDecoration(
                      color: theme.background, borderRadius: Decorate.r16),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: reactList
                        .map((e) => IconButton(
                            onPressed: () {
                              controller.close();
                              widget.onReact(e.value);
                            },
                            icon: SvgPicture.asset(e.reaction)))
                        .toList(),
                  ),
                ),
              )
            ],
          ),
        ));
  }

  void _onPressedButton() {
    if (controller.isOpen) {
      controller.close();
    } else {
      controller.open();
      _controller.reset();
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
