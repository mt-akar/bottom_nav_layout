import 'package:bottom_bar_with_sheet/bottom_bar_with_sheet.dart';
import 'package:bottom_nav_layout/bottom_nav_layout.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart' as SC;
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart' as WD;

import 'examples/app_in_demo.dart';
import 'examples/navigation_example.dart';
import 'examples/page_transition_example.dart';
import 'examples/quick_start.dart';
import 'pages/slider_page.dart';

var quickStartExample = QuickStartApp();
var allParametersExample = AllParametersExample();
var pageTransitionExampleApp = PageTransitionExample();
var navigationExample = NavigationExample();
var appInDemo = AppInDemo();

/// Use different examples
void main() => runApp(MaterialApp(home: pageTransitionExampleApp));

/// README: https://github.com/m-azyoksul/bottom_nav_layout/blob/main/README.md#parameters
class AllParametersExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavLayout(
      pages: [
        (_) => Center(child: Text("Welcome to bottom_nav_layout")),
        (_) => SliderPage(),
        (_) => Center(
            child: TextField(decoration: InputDecoration(hintText: 'Go..'))),
      ],
      savePageState: false,
      lazyLoadPages: false,
      // StandardPageStack, ReorderToFrontExceptFirstPageStack, NoPageStack, FirstAndLastPageStack
      pageStack: ReorderToFrontPageStack(initialPage: 0),
      extendBody: false,
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: (currentIndex, onTap) =>
          _buildGNav(currentIndex, onTap),
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
