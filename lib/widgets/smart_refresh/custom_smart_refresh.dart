import 'package:finplus/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CustomSmartRefresher extends StatelessWidget {
  final RefreshController controller;
  final VoidCallback? onLoading;
  final VoidCallback? onRefresh;
  final Widget child;
  final Axis? scrollDirection;
  const CustomSmartRefresher({
    Key? key,
    required this.controller,
    this.onLoading,
    required this.child,
    this.onRefresh,
    this.scrollDirection,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: controller,
      enablePullDown: onRefresh != null,
      enablePullUp: onLoading != null,
      onLoading: onLoading,
      onRefresh: onRefresh,
      child: child,
      scrollDirection: scrollDirection,
      footer: CustomFooter(
        builder: (context, mode) {
          Widget body;
          if (mode == LoadStatus.idle) {
            body = const Text('See more');
          } else if (mode == LoadStatus.loading) {
            body = CircularProgressIndicator(
              color: context.t.primary_01,
            );
          } else if (mode == LoadStatus.failed) {
            body = const Text('Please try again');
          } else if (mode == LoadStatus.canLoading) {
            body = const Text('Release to load more');
          } else {
            body = const Text('');
          }
          return SizedBox(
            height: 55.0,
            child: Center(
              child: body,
            ),
          );
        },
      ),
    );
  }
}
