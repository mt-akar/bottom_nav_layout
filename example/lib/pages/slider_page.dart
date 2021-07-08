import 'package:flutter/material.dart';

/// [SliderPage] a very simple stateful widget. We can easily change and observe its state.
/// It is used to demonstrate the state preservation of [BottomNavLayout]
class SliderPage extends StatefulWidget {
  @override
  _SliderPageState createState() => _SliderPageState();
}

class _SliderPageState extends State<SliderPage> {
  double r = 0;

  @override
  Widget build(BuildContext context) => Center(
        child: Slider(
          value: r,
          onChanged: (double d) => setState(() => r = d),
        ),
      );
}
