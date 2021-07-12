import 'package:flutter/material.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';

import '../nav_bar_delegate.dart';
import '../layout.dart';

/// This class contains parameters used to create a [WaterDropNavBar] instance, except [WaterDropNavBar.selectedIndex]
/// which is encapsulated in [BottomNavLayout.pageStack]
///
/// Check out the documentation for [WaterDropNavBar]
/// https://pub.dev/packages/water_drop_nav_bar
class WaterDropNavBarDelegate extends NavBarDelegate {
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

  Widget createBar(int pageStackPeek, void Function(int) onPageSelected) {
    return WaterDropNavBar(
        key: key,
        barItems: barItems,
        selectedIndex: pageStackPeek,
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
