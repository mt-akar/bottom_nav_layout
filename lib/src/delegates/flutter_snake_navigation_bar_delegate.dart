import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';

import '../nav_bar_delegate.dart';
import '../layout.dart';

/// This class contains parameters used to create a [SnakeNavigationBar] instance, except [SnakeNavigationBarDelegate.currentIndex]
/// which is encapsulated in [BottomNavLayout.pageStack]
///
/// Check out the documentation for [SnakeNavigationBar]
class SnakeNavigationBarDelegate extends NavBarDelegate {
  SnakeNavigationBarDelegate({
    this.key,
    this.snakeViewColor,
    this.backgroundColor,
    this.selectedItemColor,
    this.unselectedItemColor,
    this.showSelectedLabels = false,
    this.showUnselectedLabels = false,
    this.items,
    this.shape,
    this.padding = EdgeInsets.zero,
    this.elevation = 0.0,
    this.onTap,
    this.behaviour = SnakeBarBehaviour.pinned,
    this.snakeShape = SnakeShape.circle,
    this.shadowColor = Colors.black,
    this.selectedLabelStyle,
    this.unselectedLabelStyle,
    required this.height,
  });

  final Key? key;
  final Color? snakeViewColor;
  final Color? backgroundColor;
  final Color? selectedItemColor;
  final Color? unselectedItemColor;
  final bool showSelectedLabels;
  final bool showUnselectedLabels;
  final List<BottomNavigationBarItem>? items;
  final ShapeBorder? shape;
  final EdgeInsets padding;
  final double elevation;
  final ValueChanged<int>? onTap;
  final SnakeBarBehaviour behaviour;
  final SnakeShape snakeShape;
  final Color shadowColor;
  final TextStyle? selectedLabelStyle;
  final TextStyle? unselectedLabelStyle;
  final double height;

  Widget createBar(int pageStackPeek, void Function(int) onPageSelected) {
    return SnakeNavigationBar.color(
      key: key,
      snakeViewColor: snakeViewColor,
      backgroundColor: backgroundColor,
      selectedItemColor: selectedItemColor,
      unselectedItemColor: unselectedItemColor,
      showSelectedLabels: showSelectedLabels,
      showUnselectedLabels: showUnselectedLabels,
      items: items,
      currentIndex: pageStackPeek,
      shape: shape,
      padding: padding,
      elevation: elevation,
      onTap: (index) {
        // Layout functionality
        onPageSelected(index);

        // Passed in onTap call
        onTap?.call(index);
      },
      behaviour: behaviour,
      snakeShape: snakeShape,
      shadowColor: shadowColor,
      selectedLabelStyle: selectedLabelStyle,
      unselectedLabelStyle: unselectedLabelStyle,
    );
  }

  @override
  int itemLength() {
    return items?.length ?? 0;
  }
}
