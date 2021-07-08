import 'package:bottom_nav_layout/bottom_nav_layout.dart';
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

void main() => runApp(MaterialApp(
      home: SalomonBottomNavLayout(
        // The app's top level destinations
        pages: [
          Center(child: Text("Welcome to bottom_nav_layout")),
          GamePage('TicTacToe'),
          Center(child: TextField(decoration: InputDecoration(hintText: 'Enter search term...'))),
        ],
        items: [
          SalomonBottomBarItem(icon: Icon(Icons.home), title: Text('Home')),
          SalomonBottomBarItem(icon: Icon(Icons.gamepad), title: Text('Game')),
          SalomonBottomBarItem(icon: Icon(Icons.search), title: Text('Search')),
        ],
      ),
    ));

/// [GamePage] a very simple stateful widget. We can easily change and observe its state.
/// It is used to demonstrate the state preservation of [BottomNavLayout]
class GamePage extends StatefulWidget {
  final String name;

  GamePage(this.name);

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  // The page's state
  double rating = 0;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text("${widget.name}")),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Pick a difficulty"),
            Slider(
              value: rating,
              divisions: 10,
              label: '$rating',
              onChanged: (double value) => setState(() => rating = value),
            ),
            ElevatedButton(onPressed: () {}, child: Text("Play"))
          ],
        ),
      );
}
