import 'package:bottom_nav_layout/bottom_nav_layout.dart';
import 'package:flutter/material.dart';

/// Create a class that extends [NavBarDelegate]
class MyNavBarDelegate extends NavBarDelegate {
  /// Declare necessary properties
  final List<BottomNavigationBarItem> items;
  final void Function(int)? onTap;

  //
  // Other properties...
  //

  /// Create a constructor
  MyNavBarDelegate({
    required this.items,
    this.onTap,
    //
    // Other properties...
    //
  });

  /// Implement [NavBarDelegate.createBar] that returns the bottom navbar widget.
  ///
  /// Param [pageStackPeek] should be passed into the index parameter (initialTab/selectedPage/currentIndex/etc).
  /// Param [onPageSelected] should be called along with the tap action.
  Widget createBar(int pageStackPeek, void Function(int) onPageSelected) {
    // Create and return the bottom navbar you like.
    // This will be shown on the bottom of the layout.
    return BottomNavigationBar(
      items: items,
      currentIndex: pageStackPeek,
      onTap: (index) {
        // Layout functionality
        onPageSelected(index);

        // Passed in onTap call
        onTap?.call(index);
      },
      //
      // Other properties...
      //
    );
  }

  /// Implement [NavBarDelegate.itemLength] that returns the number of bottom navbar items.
  int itemLength() {
    return items.length;
  }
}
