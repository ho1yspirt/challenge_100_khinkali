import 'package:flutter/material.dart';

class PersistentHeader extends SliverPersistentHeaderDelegate {
  const PersistentHeader({
    required this.child,
    this.alignment = AlignmentDirectional.center,
    this.padding = EdgeInsets.zero,
    this.color,
  });

  final Widget child;
  final AlignmentGeometry alignment;
  final EdgeInsets padding;
  final Color? color;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Material(
      surfaceTintColor: Colors.transparent,
      color: color ?? Theme.of(context).colorScheme.surface,
      child: Padding(
        padding: padding,
        child: Align(alignment: alignment, child: child),
      ),
    );
  }

  @override
  double get maxExtent => 40.0;

  @override
  double get minExtent => 40.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
