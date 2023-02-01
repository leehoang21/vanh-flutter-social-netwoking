import 'package:flutter/material.dart';

const double _expand = 50;

class DragReply extends StatefulWidget {
  final Widget child;
  final VoidCallback? onDragMaxExpand;
  // final Widget reactButton;
  const DragReply({
    Key? key,
    required this.child,
    this.onDragMaxExpand,
    // required this.reactButton
  }) : super(key: key);

  @override
  State<DragReply> createState() => _DragReplyState();
}

class _DragReplyState extends State<DragReply> with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  double startPoint = 0;
  bool hasNotify = true;

  @override
  void initState() {
    _controller = AnimationController(
        duration: const Duration(milliseconds: 100), vsync: this);

    _animation = Tween<double>(begin: 0, end: _expand).animate(_controller);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _SwipeBouncing(
      onHorizontalDragUpdate: (details) {
        _controller.value = (details.localPosition.dx - startPoint) / _expand;

        if (hasNotify && _controller.value == 1) {
          hasNotify = false;
          widget.onDragMaxExpand?.call();
        }
      },
      onHorizontalDragStart: (details) {
        startPoint = details.localPosition.dx;
      },
      onHorizontalDragEnd: (_) {
        hasNotify = true;
        _controller.reverse();
      },
      position: _animation,
      child: widget.child,
      // reactButton: widget.reactButton,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class _SwipeBouncing extends AnimatedWidget {
  final Widget child;
  // final Widget reactButton;
  final Function(DragUpdateDetails)? onHorizontalDragUpdate;
  final Function(DragEndDetails)? onHorizontalDragEnd;
  final Function(DragStartDetails)? onHorizontalDragStart;
  const _SwipeBouncing({
    // required this.reactButton,
    required Animation<double> position,
    required this.child,
    this.onHorizontalDragUpdate,
    this.onHorizontalDragEnd,
    this.onHorizontalDragStart,
  }) : super(listenable: position);

  Animation<double> get position => listenable as Animation<double>;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          left: position.value,
          right: -position.value,
          top: 0,
          bottom: 0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(child: child),
              // reactButton
            ],
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: GestureDetector(
                onHorizontalDragStart: onHorizontalDragStart,
                onHorizontalDragUpdate: onHorizontalDragUpdate,
                onHorizontalDragEnd: onHorizontalDragEnd,
                child: Opacity(
                  opacity: 0,
                  child: child,
                ),
              ),
            ),
            // Opacity(opacity: 0.01, child: reactButton)
          ],
        ),
      ],
    );
  }
}
