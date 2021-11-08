import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// [NavigatorWithoutRouteNames] is a quick way to create a navigator.
/// It uses Flutter's standard navigation widget.
/// It doesn't use route names. You can achieve full navigation
/// by pushing and popping widgets without using routes.
///
/// Use the following calls inside your page:
/// Navigator.push(context, MaterialPageRoute(builder: (_) => PageToPush()));
/// Navigator.pop(context);
/// Navigator.popUntil(context, (route) => route.isFirst);
/// var canPop = Navigator.canPop(context);
/// var popped = Navigator.maybePop(context);
class NavigatorWithoutRouteNames extends StatelessWidget {
  NavigatorWithoutRouteNames({required this.navKey, required this.initialPage});

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

/// This class contains extension methods.
class NavExtensions {
  /// Simply push a widget with MaterialPageRoute
  static void push(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => page));
  }

  /// Simply push a widget with CupertinoPageRoute
  static void pushCupertino(BuildContext context, Widget page) {
    Navigator.push(context, CupertinoPageRoute(builder: (_) => page));
  }
}
