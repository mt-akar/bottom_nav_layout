import 'package:bottom_nav_layout/bottom_nav_layout.dart';
import 'package:example/game_page.dart';
import 'package:flutter/material.dart';

class QuickStartApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavLayout(
      // The app's top level destinations
      pages: [
        Center(child: Text("Welcome to bottom_nav_layout")),
        GamePage('TicTacToe'),
        Center(child: TextField(decoration: InputDecoration(hintText: 'Search...'))),
      ],
      // savePageState: true, // Default is true
      // pageStack: ReorderToFrontPageStack(initialPage: 0), // Default is ReorderToFrontPageStack
      // bottomBarStyler: (bottomBar) => Padding(
      //   padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
      //   child: bottomBar,
      // ),
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.gamepad), label: 'Game'),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
      ],
    );
  }
}
