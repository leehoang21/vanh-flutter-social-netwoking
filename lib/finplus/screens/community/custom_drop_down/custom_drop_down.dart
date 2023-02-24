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
  final LayerLink _layerLink = LayerLink();
  late OverlayEntry _overlayEntry;
  bool show = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        onTap: () {
          if (!show) {
            _overlayEntry = _getOverlay();
            widget.onTapDropDown?.call();
            Overlay.of(context)?.insert(_overlayEntry);
            show = true;
          } else {
            _overlayEntry.remove();
            show = false;
          }
        },
        child: widget.child ?? const SizedBox(),
      ),
    );
  }

  OverlayEntry _getOverlay() {
    final size = context.size;
    return OverlayEntry(
        maintainState: true,
        builder: (ctx) => Material(
              color: Colors.transparent,
              child: InkWell(
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                splashColor: Colors.transparent,
                overlayColor: MaterialStateProperty.all(Colors.transparent),
                highlightColor: Colors.transparent,
                onTap: () {
                  widget.onTapDropDownInAction?.call();
                  if (show = true) {
                    _overlayEntry.remove();
                    show = false;
                  }
                },
                child: Stack(
                  children: [
                    Positioned(
                        child: CompositedTransformFollower(
                      link: _layerLink,
                      showWhenUnlinked: false,
                      followerAnchor: Alignment.topRight,
                      offset: Offset(
                          (size?.width ?? 0) / 2 + 15 / 2, size?.height ?? 0),
                      child: CustomPaint(
                        size: const Size(15, 10),
                        painter: _TrianglePaint(),
                      ),
                    )),
                    Positioned(
                        child: CompositedTransformFollower(
                      link: _layerLink,
                      showWhenUnlinked: false,
                      followerAnchor: Alignment.topRight,
                      offset: Offset(
                          (size?.width ?? 0) + 8, (size?.height ?? 0) + 9.0),
                      child: SizedBox(
                        width: 215,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: widget.dropdownColor ??
                                  const Color.fromRGBO(248, 251, 255, 1),
                              boxShadow: const [
                                BoxShadow(
                                    color: Color.fromRGBO(0, 0, 0, 0.1),
                                    offset: Offset(0, 2),
                                    blurRadius: 2)
                              ]),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: List.generate(
                                widget.items.length,
                                (index) => InkWell(
                                      onTap: () {
                                        if (show = true) {
                                          _overlayEntry.remove();
                                          show = false;
                                        }
                                        widget.onTapItem
                                            ?.call(widget.items[index], index);
                                      },
                                      child: widget.itemBuilder(
                                          widget.items[index], index),
                                    )),
                          ),
                        ),
                      ),
                    ))
                  ],
                ),
              ),
            ));
  }
}

class _TrianglePaint extends CustomPainter {
  final painter = Paint()
    ..color = const Color.fromRGBO(248, 251, 255, 1)
    ..style = PaintingStyle.fill;

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    path.moveTo(size.width / 2, 0);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.close();

    canvas.drawPath(path, painter);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
