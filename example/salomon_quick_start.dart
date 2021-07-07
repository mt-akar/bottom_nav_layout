import 'package:bottom_nav_layout/bottom_nav_layout.dart';
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SalomonBottomNavLayout(
        // Your app's top level destinations
        pages: [
          Center(child: Text("Welcome to bottom_nav_layout")),
          ExamplePage('Music'),
          ExamplePage('Place'),
          Center(child: TextField(decoration: InputDecoration(hintText: 'Enter search term...'))),
        ],

        // Visual properties. Delegate the following properties to a flutter BottomNavigationBar
        items: [
          SalomonBottomBarItem(icon: Icon(Icons.home), activeIcon: Icon(Icons.landscape), title: Text('Home')),
          SalomonBottomBarItem(icon: Icon(Icons.music_note), activeIcon: Icon(Icons.home), title: Text('Music')),
          SalomonBottomBarItem(icon: Icon(Icons.place), activeIcon: Icon(Icons.insights), title: Text('Places')),
          SalomonBottomBarItem(icon: Icon(Icons.search), activeIcon: Icon(Icons.insights), title: Text('Search')),
        ],
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}

/// [ExamplePage] a very simple stateful widget. We can easily change and observe its state.
/// It is used to demonstrate the state preservation of [BottomNavLayout]
class ExamplePage extends StatefulWidget {
  final String name;

  ExamplePage(this.name);

  @override
  _ExamplePageState createState() => _ExamplePageState();
}

class _ExamplePageState extends State<ExamplePage> {
  // The page's state
  double rating = 0;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text("${widget.name}")),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Pick a ${widget.name}"),

            // A slider whose value can be changed easily. The value of the slider doesn't have a meaning.
            Slider(
              value: rating,
              divisions: 10,
              label: '$rating',
              onChanged: (double value) => setState(() => rating = value),
            ),
          ],
        ),
      );
}
