import 'package:bottom_nav_layout/bottom_nav_layout.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BottomNavLayout(
        pages: [
          ExamplePage('Favorite'),
          ExamplePage('Music'),
          ExamplePage('Place'),
          Center(child: TextField(decoration: InputDecoration(hintText: 'Enter search term...'))),
        ],
        // Delegates its properties to a flutter BottomNavigationBar
        bottomNavBarDelegate: BottomNavBarDelegate(
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorites'),
            BottomNavigationBarItem(icon: Icon(Icons.music_note), label: 'Music'),
            BottomNavigationBarItem(icon: Icon(Icons.place), label: 'Places'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          ],
          backgroundColor: Colors.blue,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white54,
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }
}

class ExamplePage extends StatefulWidget {
  final String name;

  ExamplePage(this.name);

  @override
  _ExamplePageState createState() => _ExamplePageState();
}

class _ExamplePageState extends State<ExamplePage> {
  double rating = 0;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text("${widget.name}")),
    body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Pick a ${widget.name}"),
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
