import 'package:bottom_bar_with_sheet/bottom_bar_with_sheet.dart';
import 'package:bottom_nav_layout/bottom_nav_layout.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:example/pages/slider_page.dart';
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart' as SC;
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart' as WD;

//void main() => runApp(MaterialApp(home: QuickStartApp()));
void main() => runApp(MaterialApp(home: AllParametersExample()));

///////////////////////////////////////////////////
/////////////////// QUICK START ///////////////////
///////////////////////////////////////////////////
class QuickStartApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavLayout(
      // The app's top level destinations
      pages: [
        Center(child: Text("Welcome to bottom_nav_layout")),
        SliderPage(),
        Center(child: TextField(decoration: InputDecoration(hintText: 'Go..'))),
      ],

      // Delegates all it's properties to a [BottomNavigationBar] instance.
      navBarDelegate: BottomNavigationBarDelegate(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.linear_scale), label: 'Slider'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
        ],
      ),
    );
  }
}

///////////////////////////////////////////////////
///////////////// ALL PARAMETERS //////////////////
///////////////////////////////////////////////////
class AllParametersExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavLayout(
      // The app's top level destinations
      pages: [
        Center(child: Text("Welcome to bottom_nav_layout")),
        SliderPage(),
        Center(child: TextField(decoration: InputDecoration(hintText: 'Go..'))),
      ],

      // // Also the app's top level destinations, but lazily loaded.
      // pageBuilders: [
      //   () => Center(child: Text("Welcome to bottom_nav_layout")),
      //   () => SliderPage(),
      //   () => Center(child: TextField(decoration: InputDecoration(hintText: 'Go..'))),
      // ],

      // Enables or disables the page state preservation. Default is true.
      savePageState: true,

      // Default is `ReorderToFrontPageStack(initialPage: 0)`
      pageStack: ReorderToFrontPageStack(initialPage: 0),
      // pageStack: StandardPageStack(initialPage: 0),
      // pageStack: ReorderToFrontExceptFirstPageStack(initialPage: 0),
      // pageStack: NoPageStack(initialPage: 0),
      // pageStack: FirstAndLastPageStack(initialPage: 0),

      // Navigation keys. Default is null.
      keys: <GlobalKey<NavigatorState>?>[null, null, null],

      // Widget that styles the bottom bar. Default is null.
      bottomBarWrapper: (bottomBar) => Padding(
        padding: EdgeInsets.zero,
        child: bottomBar,
      ),

      // Similar to [Scaffold.extendBody]. Default is false.
      extendBody: false,

      // Similar to [Scaffold.resizeToAvoidBottomInset]. Default is true.
      resizeToAvoidBottomInset: true,

      // Delegates all it's properties to a bottom bar.
      navBarDelegate: _buildBottomNavigationBarDelegate(),
      // navBarDelegate: _buildConvexAppBarDelegate(),
      // navBarDelegate: _buildSnakeNavigationBarDelegate(),
      // navBarDelegate: _buildSalomonBottomBarDelegate(),
      // navBarDelegate: _buildBottomBarWithSheetDelegate(),
      // navBarDelegate: _buildWaterDropNavBarDelegate(),
      // navBarDelegate: _buildSlidingClippedNavBarDelegate(),
    );
  }

  //// BUILD FUNCTIONS ////

  NavBarDelegate _buildBottomNavigationBarDelegate() =>
      BottomNavigationBarDelegate(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.linear_scale), label: 'Slider'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
        ],
      );

  NavBarDelegate _buildConvexAppBarDelegate() => ConvexAppBarDelegate(
        items: [
          TabItem(icon: Icon(Icons.home), title: 'Home'),
          TabItem(icon: Icon(Icons.linear_scale), title: 'Slider'),
          TabItem(icon: Icon(Icons.search), title: 'Search'),
        ],
      );

  NavBarDelegate _buildSnakeNavigationBarDelegate() =>
      SnakeNavigationBarDelegate(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.maximize), label: 'Slider'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
        ],
        height: 56,
      );

  NavBarDelegate _buildSalomonBottomBarDelegate() => SalomonBottomBarDelegate(
        items: [
          SalomonBottomBarItem(icon: Icon(Icons.home), title: Text('Home')),
          SalomonBottomBarItem(
              icon: Icon(Icons.maximize), title: Text('Slider')),
          SalomonBottomBarItem(icon: Icon(Icons.search), title: Text('Search')),
        ],
      );

  NavBarDelegate _buildBottomBarWithSheetDelegate() =>
      BottomBarWithSheetDelegate(
        items: [
          BottomBarWithSheetItem(icon: Icons.home),
          BottomBarWithSheetItem(icon: Icons.linear_scale),
          BottomBarWithSheetItem(icon: Icons.linear_scale),
          BottomBarWithSheetItem(icon: Icons.search),
        ],
        sheetChild: Center(child: Text("Welcome to sheetChild")),
      );

  NavBarDelegate _buildWaterDropNavBarDelegate() => WaterDropNavBarDelegate(
        barItems: [
          WD.BarItem(filledIcon: Icons.home, outlinedIcon: Icons.home),
          WD.BarItem(filledIcon: Icons.maximize, outlinedIcon: Icons.maximize),
          WD.BarItem(filledIcon: Icons.search, outlinedIcon: Icons.search),
        ],
      );

  NavBarDelegate _buildSlidingClippedNavBarDelegate() =>
      SlidingClippedNavBarDelegate(
        barItems: [
          SC.BarItem(icon: Icons.home, title: 'Home'),
          SC.BarItem(icon: Icons.linear_scale, title: 'Slider'),
          SC.BarItem(icon: Icons.search, title: 'Search'),
        ],
        activeColor: Colors.blue,
      );
}
