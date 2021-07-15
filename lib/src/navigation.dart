import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoutelessNavPage extends StatelessWidget {
  RoutelessNavPage({required this.navKey, required this.initialPage});

  final GlobalKey<NavigatorState> navKey;
  final Widget initialPage;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navKey,
      onGenerateRoute: (_) => MaterialPageRoute(
        builder: (_) => initialPage,
      ),
    );
  }
}

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
