import 'package:flutter/widgets.dart';

import 'page_stack.dart';

abstract class BarDelegate {
  Widget create(PageStack pageStack, void Function(int) onPageSelected);
}