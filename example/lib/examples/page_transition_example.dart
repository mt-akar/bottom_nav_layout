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
      ),

      // If savePageState is false, pages cannot be transitioned out.
      savePageState: true,

      // Parameters related to the page transitions
      pageTransitionData: _pageTransition1(),
    );
  }

  PageTransitionData _pageTransition1() {
    return PageTransitionData(
      builder: PrebuiltAnimationBuilderBuilders.zoomInAndFadeOut,
      duration: 150,
      direction: AnimationDirection.inAndOut,
    );
  }

  /// Same as [PrebuiltAnimationBuilderBuilders.zoomInAndFadeOut]
  PageTransitionData _pageTransition2() {
    return PageTransitionData(
      builder: (controller, child) => AnimatedBuilder(
        animation: Tween(begin: 0.0, end: 1.0).animate(controller),
        builder: (context, child) => Opacity(
          opacity: controller.value,
          child: Transform.scale(
            scale: 1.05 - (controller.value * 0.05),
            child: child,
          ),
        ),
        child: child,
      ),
      duration: 150,
      direction: AnimationDirection.inAndOut,
    );
  }

  PageTransitionData _pageTransition3() {
    return PageTransitionData(
      builder: PrebuiltAnimationBuilderBuilders.fadeOut,
      duration: 150,
      direction: AnimationDirection.inAndOut,
    );
  }
}
