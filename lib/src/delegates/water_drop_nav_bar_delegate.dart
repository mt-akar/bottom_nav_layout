import 'package:flutter/material.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';

import '../bar_delegate.dart';
import '../layout.dart';
import '../page_stack.dart';

/// This class contains parameters used to create a [WaterDropNavBar] instance, except [WaterDropNavBar.selectedIndex]
/// which is encapsulated in [BottomNavLayout.pageStack]
class WaterDropNavBarDelegate extends BarDelegate {
  WaterDropNavBarDelegate({
    this.key,
    required this.barItems,
    this.onButtonPressed,
    this.backgroundColor = Colors.white,
    this.waterDropColor = const Color(0xFF5B75F0),
    this.iconSize = 30,
    this.inactiveIconColor,
  });

  final Key? key;
  final List<BarItem> barItems;
  final ValueChanged<int>? onButtonPressed;
  final Color backgroundColor;
  final Color waterDropColor;
  final double iconSize;
  final Color? inactiveIconColor;

  Widget createBar(PageStack pageStack, void Function(int) onPageSelected) {
    return WaterDropNavBar(
        key: key,
        barItems: barItems,
        selectedIndex: pageStack.peek(),
        onButtonPressed: (index) {
          // Layout functionality
          onPageSelected(index);

          // Passed in onTap call
          onButtonPressed?.call(index);
        },
        backgroundColor: backgroundColor,
        waterDropColor: waterDropColor,
        iconSize: iconSize,
        inactiveIconColor: inactiveIconColor);
  }

  @override
  int itemLength() {
    return barItems.length;
  }
}
