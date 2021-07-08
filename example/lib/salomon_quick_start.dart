import 'package:bottom_nav_layout/bottom_nav_layout.dart';
import 'package:example/game_page.dart';
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class SalomonQuickStartApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SalomonBottomNavLayout(
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
        SalomonBottomBarItem(icon: Icon(Icons.home), title: Text('Home')),
        SalomonBottomBarItem(icon: Icon(Icons.gamepad), title: Text('Game')),
        SalomonBottomBarItem(icon: Icon(Icons.search), title: Text('Search')),
      ],
    );
  }
}
