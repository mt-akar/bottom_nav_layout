import 'package:flutter/widgets.dart';

import '../page_stack.dart';

/// This the parent class for any bar delegate.
/// Has [BarDelegate.createBar] method.
abstract class BarDelegate {
  Widget createBar(PageStack pageStack, void Function(int) onPageSelected);
}