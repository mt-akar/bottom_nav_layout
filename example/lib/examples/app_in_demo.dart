import 'package:bottom_nav_layout/bottom_nav_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'navigation_example.dart';

/// This doesn't introduce something new.
/// This is the code used in the gif demo at the top of README
class AppInDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavLayout(
      pages: [
        (navKey) => HomePage(navKey: navKey),
        (navKey) => DashboardPage(
              navKey: navKey,
              initialPage: StackablePage(0, "Dashboard"),
            ),
        (navKey) => NavigatorWithoutRouteNames(
              navKey: navKey,
              initialPage: StackablePage(0, "Search"),
            ), // NavigatorWithoutRouteNames
      ],
      bottomNavigationBar: (currentIndex, onTap) => BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => onTap(index),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.dashboard), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
        ],
      ),
      savePageState: true,
      pageTransitionData: PageTransitionData(
        builder: PrebuiltAnimationBuilderBuilders.zoomInAndFadeOut,
        duration: 150,
        direction: AnimationDirection.inAndOut,
      ),
    );
  }
}
