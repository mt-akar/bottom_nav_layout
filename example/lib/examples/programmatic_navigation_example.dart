import 'package:bottom_nav_layout/bottom_nav_layout.dart';
import 'package:flutter/material.dart';

class ProgrammaticNavigationExample extends StatefulWidget {
  @override
  State<ProgrammaticNavigationExample> createState() =>
      _ProgrammaticNavigationExampleState();
}

class _ProgrammaticNavigationExampleState
    extends State<ProgrammaticNavigationExample> {
  StandardPageStack _stack = StandardPageStack(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return BottomNavLayout(
      pages: [
        (_) => Center(
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    _stack.push(1);
                  });
                },
                child: Text("Go to dashboard page"),
              ),
            ),
        (_) => Center(
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    _stack.push(0);
                  });
                },
                child: Text("Go to home page"),
              ),
            ),
      ],
      pageStack: _stack,
      bottomNavigationBar: (currentIndex, onTap) => BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => onTap(index),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.dashboard), label: 'Dashboard'),
        ],
      ),
    );
  }
}
