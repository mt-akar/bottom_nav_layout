import 'package:bottom_bar_with_sheet/bottom_bar_with_sheet.dart';
import 'package:bottom_nav_layout/bottom_nav_layout.dart';
import 'package:example/pages/slider_page.dart';
import 'package:flutter/material.dart';

class TrialApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavLayout(
      // The app's top level destinations
      pages: [
        Center(child: Text("Welcome to bottom_nav_layout")),
        SliderPage(),
        SliderPage(),
        Center(child: TextField(decoration: InputDecoration(hintText: 'Go..'))),
      ],
      // Delegates all it's properties to a [BottomNavigationBar] instance.
      navBarDelegate: BottomBarWithSheetDelegate(
        items: [
          BottomBarWithSheetItem(icon: Icons.home),
          BottomBarWithSheetItem(icon: Icons.maximize),
          BottomBarWithSheetItem(icon: Icons.linear_scale),
          BottomBarWithSheetItem(icon: Icons.search),
        ],
        bottomBarTheme: BottomBarTheme(
          backgroundColor: Colors.orange,
        ),
        sheetChild: Text("Welcome to sheetChild"),
      ),
    );
  }
}
