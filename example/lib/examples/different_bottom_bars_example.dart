import 'package:bottom_bar_with_sheet/bottom_bar_with_sheet.dart';
import 'package:bottom_nav_layout/bottom_nav_layout.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:example/pages/slider_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart' as SC;
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart' as WD;

/// This example showcases usage of different bottom bar packages with BottomNavLayout
class DifferentBottomBarsExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavLayout(
      pages: [
        (_) => Center(child: Text("Welcome to bottom_nav_layout")),
        (_) => SliderPage(),
        (_) => Center(
            child: TextField(decoration: InputDecoration(hintText: 'Go..'))),
      ],
      bottomNavigationBar: (currentIndex, onTap) =>
          _buildSnakeNavigationBar(currentIndex, onTap),
    );
  }

  ///////////////////////////////////////////////
  /////////////// BUILD FUNCTIONS ///////////////
  //// There are 9 example bottom bars here. ////
  ///////////////////////////////////////////////

  Widget _buildBottomNavigationBar(int currentIndex, Function(int) onTap) =>
      BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => onTap(index),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.linear_scale), label: 'Slider'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
        ],
      );

  Widget _buildCupertinoTabBar(int currentIndex, Function(int) onTap) =>
      CupertinoTabBar(
        currentIndex: currentIndex,
        onTap: (index) => onTap(index),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.linear_scale), label: 'Slider'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
        ],
      );

  Widget _buildGNav(int currentIndex, Function(int) onTap) => GNav(
        selectedIndex: currentIndex,
        onTabChange: (index) => onTap(index),
        tabs: [
          GButton(icon: Icons.home, text: 'Home'),
          GButton(icon: Icons.linear_scale, text: 'Slider'),
          GButton(icon: Icons.search, text: 'Search'),
        ],
      );

  Widget _buildSnakeNavigationBar(int currentIndex, Function(int) onTap) =>
      SnakeNavigationBar.color(
        currentIndex: currentIndex,
        onTap: (index) => onTap(index),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.linear_scale), label: 'Slider'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
        ],
      );

  Widget _buildSalomonBottomBar(int currentIndex, Function(int) onTap) =>
      SalomonBottomBar(
        currentIndex: currentIndex,
        onTap: (index) => onTap(index),
        items: [
          SalomonBottomBarItem(icon: Icon(Icons.home), title: Text('Home')),
          SalomonBottomBarItem(
              icon: Icon(Icons.linear_scale), title: Text('Slider')),
          SalomonBottomBarItem(icon: Icon(Icons.search), title: Text('Search')),
        ],
      );

  /// [ConvexAppBar.initialActiveIndex] doesn't act like a currentIndex.
  /// Therefore, navigation between pages with back button is not possible.
  /// Use [NoPageStack] with it.
  Widget _buildConvexAppBar(int currentIndex, Function(int) onTap) =>
      ConvexAppBar(
        initialActiveIndex: currentIndex,
        onTap: (index) => onTap(index),
        items: [
          TabItem(icon: Icon(Icons.home), title: 'Home'),
          TabItem(icon: Icon(Icons.linear_scale), title: 'Slider'),
          TabItem(icon: Icon(Icons.search), title: 'Search'),
        ],
      );

  /// [BottomBarWithSheet.selectedIndex] doesn't act like a currentIndex.
  /// Therefore, navigation between pages with back button is not possible.
  /// Use [NoPageStack] with it.
  Widget _buildBottomBarWithSheet(int currentIndex, Function(int) onTap) =>
      BottomBarWithSheet(
        selectedIndex: currentIndex,
        onSelectItem: (index) => onTap(index),
        items: [
          BottomBarWithSheetItem(icon: Icons.home, label: 'Home'),
          BottomBarWithSheetItem(icon: Icons.linear_scale, label: 'Slider'),
          BottomBarWithSheetItem(icon: Icons.search, label: 'Search'),
        ],
        sheetChild: Center(child: Text("Welcome to sheetChild")),
        bottomBarTheme:
            BottomBarTheme(mainButtonPosition: MainButtonPosition.right),
      );

  /// [WaterDropNavBar.selectedIndex] acts like a current index but
  /// changing the page through [selectedIndex] causes visual problems.
  /// Use [NoPageStack] with it.
  Widget _buildWaterDropNavBar(int currentIndex, Function(int) onTap) =>
      WD.WaterDropNavBar(
        selectedIndex: currentIndex,
        onButtonPressed: (index) => onTap(index),
        barItems: [
          WD.BarItem(filledIcon: Icons.home, outlinedIcon: Icons.home),
          WD.BarItem(filledIcon: Icons.maximize, outlinedIcon: Icons.maximize),
          WD.BarItem(filledIcon: Icons.search, outlinedIcon: Icons.search),
        ],
      );

  /// [SlidingClippedNavBar.selectedIndex] acts like a current index but
  /// changing the page through [selectedIndex] causes visual problems.
  /// Use [NoPageStack] with it.
  Widget _buildSlidingClippedNavBar(int currentIndex, Function(int) onTap) =>
      SC.SlidingClippedNavBar(
        selectedIndex: currentIndex,
        onButtonPressed: (index) => onTap(index),
        barItems: [
          SC.BarItem(icon: Icons.home, title: 'Home'),
          SC.BarItem(icon: Icons.linear_scale, title: 'Slider'),
          SC.BarItem(icon: Icons.search, title: 'Search'),
        ],
        activeColor: Colors.blue,
      );
}
