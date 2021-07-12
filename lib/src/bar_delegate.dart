import 'package:flutter/widgets.dart';

/// This the parent class for any bar delegate.
/// [NavBarDelegate]s are used to create different bottom bar objects.
///
/// Layout class doesn't care about which bottom bar (or it's delegate for that matter) is passed into it.
/// Layout only needs to know how to create it, which is what [NavBarDelegate.createBar] for.
/// Layout also checks that the number of bottom bar items and number of pages are the same,
/// which is what [NavBarDelegate.itemLength] for.
abstract class NavBarDelegate {
  /// Creates the corresponding bar object, using the passed in parameters.
  Widget createBar(int pageStackPeek, void Function(int) onPageSelected);

  /// Is used to validate the number of items in the layout.
  int itemLength();
}
