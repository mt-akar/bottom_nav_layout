import 'package:flutter/widgets.dart';

import 'page_stack.dart';

/// This the parent class for any bar delegate.
/// Has [BarDelegate.createBar] and [BarDelegate.itemLength] methods.
abstract class BarDelegate {
  /// Creates the corresponding bar object, using the passed in parameters.
  Widget createBar(PageStack pageStack, void Function(int) onPageSelected);

  /// Is used to validate the number of items in the layout.
  int itemLength();
}
