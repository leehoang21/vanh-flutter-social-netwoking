import 'package:commons/custom_tooltip/custom_tooltip.dart';
import 'package:finplus/utils/styles.dart';
import 'package:flutter/material.dart';

class CustomDropdown<T> extends StatefulWidget {
  final Widget? child;
  final Function()? onTapDropDown;
  final Function()? onTapDropDownInAction;

  final Widget Function(T, int) itemBuilder;
  final void Function(T, int)? onTapItem;
  final List<T> items;
  final Color? dropdownColor;
  const CustomDropdown(
      {Key? key,
      this.child,
      this.onTapDropDown,
      required this.itemBuilder,
      required this.items,
      this.dropdownColor,
      this.onTapItem,
      this.onTapDropDownInAction})
      : super(key: key);

  @override
  _CustomDropdownState<T> createState() => _CustomDropdownState<T>();
}

class _CustomDropdownState<T> extends State<CustomDropdown<T>> {
  late final CustomToolTipController controller;
  bool show = false;

  @override
  void initState() {
    controller = CustomToolTipController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.t;
    return CustomToolTip(
        tooltipSpace: 1,
        tooltipBottomStart: TooltipBottomStart.right,
        controller: controller,
        direction: TooltipDirection.bottom,
        child: widget.child ?? const SizedBox(),
        tooltip: Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    offset: const Offset(0, 2),
                    blurRadius: 2,
                    color: theme.secondary_01.withOpacity(0.2))
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(
                widget.items.length,
                (index) => InkWell(
                      onTap: () {
                        widget.onTapItem?.call(widget.items[index], index);
                        controller.close();
                      },
                      child: widget.itemBuilder(widget.items[index], index),
                    )),
          ),
        ));
  }
}
