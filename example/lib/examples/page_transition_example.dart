import 'package:bottom_nav_layout/bottom_nav_layout.dart';
import 'package:flutter/material.dart';

import '../pages/slider_page.dart';

/// Page transition animation example with bottom_nav_layout package.
class PageTransitionExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavLayout(
      // The app's destinations
      pages: [
        (_) => Center(child: Text("Welcome to bottom_nav_layout")),
        (_) => SliderPage(),
        (_) => Center(
            child: TextField(decoration: InputDecoration(hintText: 'Go..'))),
      ],
      bottomNavigationBar: (currentIndex, onTap) => BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => onTap(index),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.linear_scale), label: 'Slider'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          //BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        type: BottomNavigationBarType.fixed,
      ),

      // If savePageState is false, pages cannot be transitioned out.
      savePageState: true,

      // Parameters related to the page transitions
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
