import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class SkeletonItemWidget extends StatefulWidget {
  const SkeletonItemWidget({super.key, required this.isLoading, required this.widgetItem});
  final bool isLoading;
  final Widget widgetItem;
  @override
  State<SkeletonItemWidget> createState() => _SkeletonItemWidgetState();
}

class _SkeletonItemWidgetState extends State<SkeletonItemWidget> {
  @override
  Widget build(BuildContext context) {
    return widget.isLoading ? SkeletonItem(child: widget.widgetItem) : widget.widgetItem;
  }
}
