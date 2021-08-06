import 'package:bottom_nav_layout/bottom_nav_layout.dart';
import 'package:flutter/material.dart';

class PageBackStackExample extends StatefulWidget {
  @override
  _PageBackStackExampleState createState() => _PageBackStackExampleState();
}

class _PageBackStackExampleState extends State<PageBackStackExample> {
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
  var myPageStack = FirstAndLastPageStack(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return BottomNavLayout(
      pages: [
        (_) => Center(
              child: ElevatedButton(
                onPressed: () => setState(() => myPageStack.push(1)),
                child: Text("Go to next page"),
              ),
            ),
        (_) => Center(
              child: ElevatedButton(
                onPressed: () => setState(() => myPageStack.push(2)),
                child: Text("Go to next page"),
              ),
            ),
        (_) => Center(
              child: ElevatedButton(
                onPressed: () => setState(() => myPageStack.push(0)),
                child: Text("Go to next page"),
              ),
            ),
      ],
      bottomNavigationBar: (currentIndex, onTap) => BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => onTap(index), // onTap: onTap,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.linear_scale), label: 'Slider'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
        ],
      ),
      // Set the page back stack like so
      pageStack: myPageStack,
    );
  }
}
