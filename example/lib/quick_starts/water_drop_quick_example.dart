import 'package:bottom_nav_layout/bottom_nav_layout.dart';
import 'package:example/pages/slider_page.dart';
import 'package:flutter/material.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';

class WaterDropQuickStartApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WaterDropNavLayout(
      // The app's top level destinations
      pages: [
        Center(child: Text("Welcome to bottom_nav_layout")),
        SliderPage(),
        Center(child: TextField(decoration: InputDecoration(hintText: 'Go..'))),
      ],
      barItems: [
        BarItem(
            filledIcon: Icons.home_filled, outlinedIcon: Icons.home_outlined),
        BarItem(
            filledIcon: Icons.linear_scale,
            outlinedIcon: Icons.linear_scale_outlined),
        BarItem(filledIcon: Icons.search, outlinedIcon: Icons.search),
      ],
    );
  }
}
