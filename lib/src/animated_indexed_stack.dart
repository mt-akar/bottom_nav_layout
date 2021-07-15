import 'package:flutter/material.dart';

/// Credit: https://gist.github.com/cirnok/e1b70f5d841e47c9d85ccdf6ae866984
class AnimatedIndexedStack extends StatefulWidget {
  final int index;
  final List<Widget> children;
  final Widget Function(AnimationController, Widget) pageTransitionAnimationBuilder;

  const AnimatedIndexedStack({
    Key? key,
    required this.index,
    required this.children,
    required this.pageTransitionAnimationBuilder,
  }) : super(key: key);

  @override
  _AnimatedIndexedStackState createState() => _AnimatedIndexedStackState();
}

class _AnimatedIndexedStackState extends State<AnimatedIndexedStack> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  int _index = 0;

  @override
  void initState() {
    _controller = AnimationController(
      duration: Duration(milliseconds: 5000),
      vsync: this,
    );

    _index = widget.index;
    _controller.forward();
    super.initState();
  }

  @override
  void didUpdateWidget(AnimatedIndexedStack oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.index != _index) {
      _controller.reverse().then((_) {
        setState(() => _index = widget.index);
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
    return widget.pageTransitionAnimationBuilder(
      _controller,
      IndexedStack(
        index: _index,
        children: widget.children,
      ),
    );
  }
}
