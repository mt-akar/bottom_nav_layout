import 'package:bottom_nav_layout/bottom_nav_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'navigation_example.dart';
import 'page_transition_example.dart';

/// In-page navigation example with bottom_nav_layout package.
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
        builder: _animationBuilder,
        duration: 150,
        direction: AnimationDirection.inAndOut,
      ),
    );
  }

  /// A builder that returns an [AnimatedBuilder]
  AnimatedBuilder _animationBuilder(
      AnimationController controller, Widget child) {
    return AnimatedBuilder(
      animation: Tween(begin: 0.0, end: 1.0).animate(controller),
      builder: (context, child) => Opacity(
        opacity: controller.value,
        child: Transform.scale(
          scale: 1.05 - (controller.value * 0.05),
          child: child,
        ),
      ),
      child: child,
    );
  }
}
