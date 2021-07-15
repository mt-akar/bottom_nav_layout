import 'package:flutter/material.dart';

/// [SliderPage] is a simple stateful widget.
/// It has a slider that animates from %0 to %50 when initialized.
///
/// It is used to demonstrate the state preservation and lazy loading.
class SliderPage extends StatefulWidget {
  @override
  _SliderPageState createState() => _SliderPageState();
}

class _SliderPageState extends State<SliderPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    // Create animation controller
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    // Animate on initialization
    _animationController.animateTo(0.5, curve: Curves.easeOut);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Center(
        child: Container(
          height: 50,
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (_, __) => Slider(
              value: _animationController.value,
              onChanged: (double d) =>
                  setState(() => _animationController.value = d),
            ),
          ),
        ),
      );
}
