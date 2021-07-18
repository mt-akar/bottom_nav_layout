import 'package:bottom_nav_layout/bottom_nav_layout.dart';
import 'package:example/pages/slider_page.dart';
import 'package:flutter/material.dart';

class QuickStartApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavLayout(
      pages: [
        (_) => Center(child: Text("Welcome to bottom_nav_layout")),
        (_) => SliderPage(),
        (_) => Center(child: TextField(decoration: InputDecoration(hintText: 'Go..'))),
      ],
      bottomNavigationBar: (currentIndex, onTap) => BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => onTap(index), // onTap: onTap,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.linear_scale), label: 'Slider'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
        ],
      ),

      // There are 5 prebuilt stack implementations
      // StandardPageStack: Normal stack behavior.
      // NoPageStack: Pop before pushing.
      // FirstAndLastPageStack: If there are 2 items on the stack, pop before pushing.
      // ReorderToFrontPageStack: When a page that is already on the stack is pushed, pop the previous one.
      // ReorderToFrontExceptFirstPageStack: Rules same as ReorderToFrontPageStack except the first element (default page).
      //
      // You can also implement your own using the guide on "extensions/extend_page_stack.dart"
      //
      // Default for Android: ReorderToFrontPageStack(initialPage: 0)
      // Default for iOS: NoPageStack(initialPage: 0)
      //
      // Set the page back stack like so
      pageStack: ReorderToFrontPageStack(initialPage: 0),
    );
  }
}
