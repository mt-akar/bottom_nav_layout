import 'package:flutter/material.dart';

/// Credit: https://gist.github.com/cirnok/e1b70f5d841e47c9d85ccdf6ae866984
class TwoWayAnimatedIndexedStack extends StatefulWidget {
  final int index;
  final List<Widget> children;
  final Widget Function(AnimationController, Widget) animationBuilder;
  final int animationDuration;

  const TwoWayAnimatedIndexedStack({
    Key? key,
    required this.index,
    required this.children,
    required this.animationBuilder,
    required this.animationDuration,
  }) : super(key: key);

  @override
  _TwoWayAnimatedIndexedStackState createState() => _TwoWayAnimatedIndexedStackState();
}

class _TwoWayAnimatedIndexedStackState extends State<TwoWayAnimatedIndexedStack> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  int _index = 0;

  @override
  void initState() {
    _controller = AnimationController(
      duration: Duration(milliseconds: widget.animationDuration),
      vsync: this,
    );

    _index = widget.index;
    _controller.forward();
    super.initState();
  }

  @override
  void didUpdateWidget(TwoWayAnimatedIndexedStack oldWidget) {
    super.didUpdateWidget(oldWidget);
    // If the index has changed
    if (widget.index != _index) {
      // Play the animation backwards
      _controller.reverse().then((_) {
        setState(() => _index = widget.index);
        // Then forwards
        _controller.forward();
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.animationBuilder(
      _controller,
      IndexedStack(
        index: _index,
        children: widget.children,
      ),
    );
  }
}
