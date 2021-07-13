import 'package:bottom_bar_with_sheet/bottom_bar_with_sheet.dart';
import 'package:flutter/material.dart';

import '../nav_bar_delegate.dart';
import '../layout.dart';

/// This class contains parameters used to create a [BottomBarWithSheet] instance, except [BottomBarWithSheet.selectedIndex]
/// which is encapsulated in [BottomNavLayout.pageStack]
///
/// This bottom bar doesn't have a currentIndex parameter. To ge the best result, use [ReplacePageStack] with it.
///
/// Check out the documentation for [BottomBarWithSheet]
/// https://pub.dev/packages/bottom_bar_with_sheet
class BottomBarWithSheetDelegate extends NavBarDelegate {
  // Constant taken from bottom_bar_with_sheet/lib/src/theme/defaults.dart
  static const constBottomBarTheme = const BottomBarTheme();

  // Constant taken from bottom_bar_with_sheet/lib/src/theme/defaults.dart
  static const constMainActionButtonTheme = const MainActionButtonTheme();

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
  final ValueChanged<int>? onSelectItem;

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
    this.onSelectItem, // This parameter's API is deliberately different. The package expects a `Function` and requires it.
  });

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
        // Passed in onTap call
        onSelectItem?.call(index);

        // Layout functionality
        onPageSelected(index);
      },
    );
  }

  @override
  int itemLength() {
    return items?.length ?? 0;
  }
}
