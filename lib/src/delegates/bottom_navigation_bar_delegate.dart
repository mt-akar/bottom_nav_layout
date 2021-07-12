import 'package:flutter/material.dart';

import '../bar_delegate.dart';
import '../layout.dart';
import '../page_stack.dart';

/// This class contains parameters used to create a [BottomNavigationBar] instance, except [BottomNavigationBar.currentIndex]
/// which is encapsulated in [BottomNavLayout.pageStack]
class BottomNavigationBarDelegate extends BarDelegate {
  BottomNavigationBarDelegate({
    this.key,
    required this.items,
    this.onTap,
    this.elevation,
    this.type,
    this.fixedColor,
    this.backgroundColor,
    this.iconSize = 24.0,
    this.selectedItemColor,
    this.unselectedItemColor,
    this.selectedIconTheme,
    this.unselectedIconTheme,
    this.selectedFontSize = 14.0,
    this.unselectedFontSize = 12.0,
    this.selectedLabelStyle,
    this.unselectedLabelStyle,
    this.showSelectedLabels,
    this.showUnselectedLabels,
    this.mouseCursor,
    this.enableFeedback,
  });

  final Key? key;
  final List<BottomNavigationBarItem> items;
  final ValueChanged<int>? onTap;
  final double? elevation;
  final BottomNavigationBarType? type;
  final Color? fixedColor;
  final Color? backgroundColor;
  final double iconSize;
  final Color? selectedItemColor;
  final Color? unselectedItemColor;
  final IconThemeData? selectedIconTheme;
  final IconThemeData? unselectedIconTheme;
  final double selectedFontSize;
  final double unselectedFontSize;
  final TextStyle? selectedLabelStyle;
  final TextStyle? unselectedLabelStyle;
  final bool? showSelectedLabels;
  final bool? showUnselectedLabels;
  final MouseCursor? mouseCursor;
  final bool? enableFeedback;

  Widget createBar(PageStack pageStack, void Function(int) onPageSelected) {
    return BottomNavigationBar(
      key: key,
      items: items,
      onTap: (index) {
        // Layout functionality
        onPageSelected(index);

        // Passed in onTap call
        onTap?.call(index);
      },
      currentIndex: pageStack.peek(),
      elevation: elevation,
      type: type,
      fixedColor: fixedColor,
      backgroundColor: backgroundColor,
      iconSize: iconSize,
      selectedItemColor: selectedItemColor,
      unselectedItemColor: unselectedItemColor,
      selectedIconTheme: selectedIconTheme,
      unselectedIconTheme: unselectedIconTheme,
      selectedFontSize: selectedFontSize,
      unselectedFontSize: unselectedFontSize,
      selectedLabelStyle: selectedLabelStyle,
      unselectedLabelStyle: unselectedLabelStyle,
      showSelectedLabels: showSelectedLabels,
      showUnselectedLabels: showUnselectedLabels,
      mouseCursor: mouseCursor,
      enableFeedback: enableFeedback,
    );
  }

  @override
  int itemLength() {
    return items.length;
  }
}
