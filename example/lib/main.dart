import 'package:bottom_nav_layout/bottom_nav_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'examples/app_in_demo.dart';
import 'examples/different_bottom_bars_example.dart';
import 'examples/navigation_example.dart';
import 'examples/page_back_stack_example.dart';
import 'examples/page_transition_example.dart';
import 'examples/quick_start.dart';
import 'pages/slider_page.dart';

var quickStartExample = QuickStartExample();
var allParametersExample = AllParametersExample();
var pageTransitionExample = PageTransitionExample();
var pageBackStackExample = PageBackStackExample();
var navigationExample = NavigationExample();
var differentBottomBarsExample = DifferentBottomBarsExample();
var appInDemo = AppInDemo();

void main() => runApp(MaterialApp(
      // Change the example from here
      home: quickStartExample,
    ));

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
      bottomNavigationBar: (currentIndex, onTap) => BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => onTap(index),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.linear_scale), label: 'Slider'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
        ],
      ),
      savePageState: false,
      lazyLoadPages: false,
      // StandardPageStack, ReorderToFrontExceptFirstPageStack, NoPageStack, FirstAndLastPageStack
      pageStack: ReorderToFrontPageStack(initialPage: 0),
      extendBody: false,
      resizeToAvoidBottomInset: true,
      pageTransitionData: null,
    );
  }
}
