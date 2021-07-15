import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// This is an extension class inside bottom_nav_layout package.
class NavExtensions {
  static void push(BuildContext context, Widget page) {
    var route;

    if (Platform.isIOS)
      route = CupertinoPageRoute(builder: (_) => page);
    else
      route = MaterialPageRoute(builder: (_) => page);

    Navigator.push(context, route);
  }
}
