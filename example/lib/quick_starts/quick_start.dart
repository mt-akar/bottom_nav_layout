import 'package:bottom_nav_layout/bottom_nav_layout.dart';
import 'package:example/pages/slider_page.dart';
import 'package:flutter/material.dart';

class QuickStartApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavLayout(
      // The app's top level destinations
      pages: [
        Center(child: Text("Welcome to bottom_nav_layout")),
        SliderPage(),
        Center(child: TextField(decoration: InputDecoration(hintText: 'Go...'))),
      ],
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.linear_scale), label: 'Slider'),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
      ],
    );
  }
}
