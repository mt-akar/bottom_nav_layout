import 'package:bottom_nav_layout/bottom_nav_layout.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';

import '../layout.dart';
import '../nav_bar_delegate.dart';

/// This class contains parameters used to create a [ConvexAppBar] instance, except [ConvexAppBar.initialActiveIndex]
/// which is encapsulated in [BottomNavLayout.pageStack].
///
/// This bottom bar doesn't have a currentIndex parameter. To ge the best result, use [NoPageStack] with it.
///
/// Check out the documentation for [ConvexAppBar].
/// https://pub.dev/packages/convex_bottom_bar
class ConvexAppBarDelegate extends NavBarDelegate {
  final Key? key;
  final List<TabItem> items;
  final bool? disableDefaultTabController;
  final GestureTapIndexCallback? onTap;
  final TapNotifier? onTabNotify;
  final TabController? controller;
  final Color? color;
  final Color? activeColor;
  final Color? backgroundColor;
  final Gradient? gradient;
  final double? height;
  final double? curveSize;
  final double? top;
  final double? elevation;
  final double? cornerRadius;
  final TabStyle? style;
  final Curve? curve;
  final ChipBuilder? chipBuilder;

  ConvexAppBarDelegate({
    this.key,
    required this.items,
    this.disableDefaultTabController,
    this.onTap,
    this.onTabNotify,
    this.controller,
    this.color,
    this.activeColor,
    this.backgroundColor,
    this.gradient,
    this.height,
    this.curveSize,
    this.top,
    this.elevation,
    this.cornerRadius,
    this.style,
    this.curve,
    this.chipBuilder,
  });

  Widget createBar(int pageStackPeek, void Function(int) onPageSelected) {
    return ConvexAppBar(
      key: key,
      items: items,
      initialActiveIndex: pageStackPeek,
      disableDefaultTabController: disableDefaultTabController,
      onTap: (index) {
        // Layout functionality
        onPageSelected(index);

        // Passed in onTap call
        onTap?.call(index);
      },
      onTabNotify: onTabNotify,
      controller: controller,
      color: color,
      activeColor: activeColor,
      backgroundColor: backgroundColor,
      gradient: gradient,
      height: height,
      curveSize: curveSize,
      top: top,
      elevation: elevation,
      cornerRadius: cornerRadius,
      style: style,
      curve: curve,
      chipBuilder: chipBuilder,
    );
  }

  @override
  int itemLength() {
    return items.length;
  }
}
