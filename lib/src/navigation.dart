import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// This uses Flutter's standard navigation widget.
/// You can achieve navigation by pushing and popping widgets without using routes.
///
/// Use the following calls inside your page:
/// Navigator.push(context, MaterialPageRoute(builder: (_) => MyPage()));
/// Navigator.pop(context);
/// var canPop = Navigator.canPop(context);
/// var popped = Navigator.maybePop(context);
/// Navigator.popUntil(context, (route) => route.isFirst);
class NamelessNavigator extends StatelessWidget {
  NamelessNavigator({required this.navKey, required this.initialPage});

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
