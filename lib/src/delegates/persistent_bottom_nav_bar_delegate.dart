import 'package:flutter/material.dart';

import '../nav_bar_delegate.dart';
import '../layout.dart';

/// This class contains parameters used to create a [PersistentTabView] instance,
/// except the parameters that provide layout functionality.
///
/// Check out the documentation for [PersistentTabView].
/// https://pub.dev/packages/persistent_bottom_nav_bar
class PersistentTabViewDelegate extends NavBarDelegate {
  final Key? key;

  PersistentTabViewDelegate({
    this.key,
  });

  Widget createBar(int pageStackPeek, void Function(int) onPageSelected) {
    return PersistentTabView(
      onTap: (index) {
        // Layout functionality
        onPageSelected(index);

        // Passed in onTap call
        onTap?.call(index);
      },
      currentIndex: pageStackPeek,
    );
  }

  @override
  int itemLength() {
    return items.length;
  }
}
