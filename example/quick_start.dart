import 'package:bottom_nav_layout/bottom_nav_layout.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BottomNavLayout(
        // Your app's top level destinations
        pages: [
          Center(child: Text("Welcome to bottom_nav_layout")),
          ExamplePage('Music'),
          ExamplePage('Place'),
          Center(child: TextField(decoration: InputDecoration(hintText: 'Enter search term...'))),
        ],

        // Delegate the following properties to a flutter BottomNavigationBar
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.music_note), label: 'Music'),
          BottomNavigationBarItem(icon: Icon(Icons.place), label: 'Places'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
        ],
        backgroundColor: Colors.blue,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white54,
        type: BottomNavigationBarType.fixed,
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
