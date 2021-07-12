import 'package:bottom_nav_layout/bottom_nav_layout.dart';
import 'package:example/pages/slider_page.dart';
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';

class AllParametersQuickStartApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavLayout(
      // The app's top level destinations
      pages: _buildPages(),

      // Also the app's top level destinations, but lazily loaded.
      // pageBuilders: _buildPageBuilders(),

      // Enables or disables the page state preservation. Default is true.
      savePageState: true,

      // Default is `ReorderToFrontPageStack(initialPage: 0)`
      pageStack: ReorderToFrontPageStack(initialPage: 0),
      // pageStack: StandardPageStack(initialPage: 0),
      // pageStack: ReorderToFrontExceptFirstPageStack(initialPage: 0),
      // pageStack: ReplacePageStack(initialPage: 0),
      // pageStack: ReplaceExceptFirstPageStack(initialPage: 0),

      // Navigation keys. Default is null.
      keys: [null, null, null],

      // Widget that wraps the bottom bar. Default is null.
      bottomBarStyler: (bottomBar) => Padding(
        padding: EdgeInsets.zero,
        child: bottomBar,
      ),

      // Similar to [Scaffold.extendBody]. Default is false.
      extendBody: false,

      // Delegates all it's properties to a bottom bar.
      barDelegate: _buildBottomNavigationBarDelegate(),
    );
  }

  ///////////////// BUILD FUNCTIONS /////////////////

  List<Widget> _buildPages() {
    return [
      Center(child: Text("Welcome to bottom_nav_layout")),
      SliderPage(),
      Center(child: TextField(decoration: InputDecoration(hintText: 'Go..'))),
    ];
  }

  List<Widget Function()> _buildPageBuilders() {
    return [
      () => Center(child: Text("Welcome to bottom_nav_layout")),
      () => SliderPage(),
      () => Center(child: TextField(decoration: InputDecoration(hintText: 'Go..'))),
    ];
  }

  NavBarDelegate _buildBottomNavigationBarDelegate() {
    return BottomNavigationBarDelegate(
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.maximize), label: 'Slider'),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
      ],
    );
  }

  NavBarDelegate _buildSalomonBottomBarDelegate() {
    return SalomonBottomBarDelegate(
      items: [
        SalomonBottomBarItem(icon: Icon(Icons.home), title: Text('Home')),
        SalomonBottomBarItem(icon: Icon(Icons.linear_scale), title: Text('Slider')),
        SalomonBottomBarItem(icon: Icon(Icons.search), title: Text('Search')),
      ],
    );
  }

  NavBarDelegate _buildWaterDropNavBarDelegate() {
    return WaterDropNavBarDelegate(
      barItems: [
        BarItem(filledIcon: Icons.home_filled, outlinedIcon: Icons.home_outlined),
        BarItem(filledIcon: Icons.linear_scale, outlinedIcon: Icons.linear_scale_outlined),
        BarItem(filledIcon: Icons.search, outlinedIcon: Icons.search),
      ],
    );
  }
}
