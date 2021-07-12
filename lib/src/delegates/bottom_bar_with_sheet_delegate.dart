import 'package:bottom_bar_with_sheet/bottom_bar_with_sheet.dart';
import 'package:flutter/material.dart';

import '../nav_bar_delegate.dart';
import '../layout.dart';

/// This class contains parameters used to create a [BottomBarWithSheet] instance, except [BottomBarWithSheet.selectedIndex]
/// which is encapsulated in [BottomNavLayout.pageStack]
///
/// Check out the documentation for [BottomBarWithSheet]
class BottomBarWithSheetDelegate extends NavBarDelegate {
  // Constant taken from bottom_bar_with_sheet/lib/src/theme/defaults.dart
  static const constBottomBarTheme = const BottomBarTheme();

  // Constant taken from bottom_bar_with_sheet/lib/src/theme/defaults.dart
  static const constMainActionButtonTheme = const MainActionButtonTheme();

  BottomBarWithSheetDelegate({
    this.key,
    this.isOpened = false,
    this.bottomBarMainAxisAlignment = MainAxisAlignment.center,
    this.duration = constDuration,
    this.curve = constCurve,
    this.disableMainActionButton = false,
    this.mainActionButton,
    this.items,
    this.bottomBarTheme = constBottomBarTheme,
    this.mainActionButtonTheme = constMainActionButtonTheme,
    this.autoClose = true,
    required this.sheetChild,
    required this.onSelectItem,
  });

  final Key? key;
  final bool isOpened;
  final MainAxisAlignment bottomBarMainAxisAlignment;
  final Duration duration;
  final Curve curve;
  final bool disableMainActionButton;
  final MainActionButton? mainActionButton;
  final List<BottomBarWithSheetItem>? items;
  final BottomBarTheme bottomBarTheme;
  final MainActionButtonTheme? mainActionButtonTheme;
  final bool autoClose;
  final Widget sheetChild;
  final Function onSelectItem;

  Widget createBar(int pageStackPeek, void Function(int) onPageSelected) {
    return BottomBarWithSheet(
      key: key,
      selectedIndex: pageStackPeek,
      isOpened: isOpened,
      bottomBarMainAxisAlignment: bottomBarMainAxisAlignment,
      duration: duration,
      curve: curve,
      disableMainActionButton: disableMainActionButton,
      mainActionButton: mainActionButton,
      items: items,
      bottomBarTheme: bottomBarTheme,
      mainActionButtonTheme: mainActionButtonTheme,
      autoClose: autoClose,
      sheetChild: sheetChild,
      onSelectItem: (index) {
        // Layout functionality
        onPageSelected(index);

        // Passed in onTap call
        onSelectItem.call(index);
      },
    );
  }

  @override
  int itemLength() {
    return items?.length ?? 0;
  }
}
