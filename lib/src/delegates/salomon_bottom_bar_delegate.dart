import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../layout.dart';
import '../page_stack.dart';
import 'bar_delegate.dart';

/// This class contains parameters used to create a [SalomonBottomBar] instance, except [SalomonBottomBar.currentIndex]
/// which is encapsulated in [BottomNavLayout.pageStack]
class SalomonBottomBarDelegate extends BarDelegate {
  SalomonBottomBarDelegate({
    this.key,
    required this.items,
    this.onTap,
    this.selectedItemColor,
    this.unselectedItemColor,
    this.selectedColorOpacity,
    this.itemShape = const StadiumBorder(),
    this.margin = const EdgeInsets.all(8),
    this.itemPadding = const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
    this.duration = const Duration(milliseconds: 500),
    this.curve = Curves.easeOutQuint,
  });

  final Key? key;
  final List<SalomonBottomBarItem> items;
  final Function(int)? onTap;
  final Color? selectedItemColor;
  final Color? unselectedItemColor;
  final double? selectedColorOpacity;
  final ShapeBorder itemShape;
  final EdgeInsets margin;
  final EdgeInsets itemPadding;
  final Duration duration;
  final Curve curve;

  Widget createBar(PageStack pageStack, void Function(int) onPageSelected) {
    return SalomonBottomBar(
      key: key,
      items: items,
      currentIndex: pageStack.peek(),
      onTap: (index) {
        // Layout functionality
        onPageSelected(index);

        // Passed in onTap call
        onTap?.call(index);
      },
      selectedItemColor: selectedItemColor,
      unselectedItemColor: unselectedItemColor,
      selectedColorOpacity: selectedColorOpacity,
      itemShape: itemShape,
      margin: margin,
      itemPadding: itemPadding,
      duration: duration,
      curve: curve,
    );
  }
}
