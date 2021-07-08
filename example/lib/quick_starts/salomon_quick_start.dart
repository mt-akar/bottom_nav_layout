import 'package:bottom_nav_layout/bottom_nav_layout.dart';
import 'package:example/pages/slider_page.dart';
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class SalomonQuickStartApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SalomonBottomNavLayout(
      // The app's top level destinations
      pages: [
        Center(child: Text("Welcome to bottom_nav_layout")),
        SliderPage(),
        Center(
            child: TextField(decoration: InputDecoration(hintText: 'Go...'))),
      ],
      items: [
        SalomonBottomBarItem(icon: Icon(Icons.home), title: Text('Home')),
        SalomonBottomBarItem(
            icon: Icon(Icons.linear_scale), title: Text('Slider')),
        SalomonBottomBarItem(icon: Icon(Icons.search), title: Text('Search')),
      ],
    );
  }
}
