import 'package:flutter/material.dart';

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
