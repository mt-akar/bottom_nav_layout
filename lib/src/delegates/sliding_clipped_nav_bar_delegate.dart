import 'package:flutter/material.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';

import '../layout.dart';
import '../nav_bar_delegate.dart';

/// This class contains parameters used to create a [SlidingClippedNavBar] instance, except [SlidingClippedNavBar.selectedIndex]
/// which is encapsulated in [BottomNavLayout.pageStack].
///
/// Check out the documentation for [SlidingClippedNavBar].
/// https://pub.dev/packages/sliding_clipped_nav_bar
class SlidingClippedNavBarDelegate extends NavBarDelegate {
  final List<BarItem> barItems;
  final void Function(int)? onButtonPressed;
  final Color activeColor;
  final Color? inactiveColor;
  final double iconSize;
  final Color backgroundColor;

  SlidingClippedNavBarDelegate({
    required this.barItems,
    this.onButtonPressed, // The API is deliberately different. You do not have to call setSate.
    required this.activeColor,
    this.inactiveColor,
    this.iconSize = 30,
    this.backgroundColor = Colors.white,
  });

  Widget createBar(int pageStackPeek, void Function(int) onPageSelected) {
    return SlidingClippedNavBar(
      barItems: barItems,
      selectedIndex: pageStackPeek,
      onButtonPressed: (index) {
        // Passed in onTap call
        onButtonPressed?.call(index);
        
        // Layout functionality
        onPageSelected(index);
      },
      activeColor: activeColor,
      inactiveColor: inactiveColor,
      iconSize: iconSize,
      backgroundColor: backgroundColor,
    );
  }

  @override
  int itemLength() {
    return barItems.length;
  }
}
