import 'package:flutter/material.dart';

/// typedef for [AnimatedBuilder] builder
typedef AnimatedBuilderBuilder = AnimatedBuilder Function(
    AnimationController, Widget);

/// Controls how the page transition will play out.
///
/// If the savePageState is false, widgets can't be animated out.
/// In that case [AnimationDirection.out] is useless and
/// [AnimationDirection.inAndOut] acts the same as [AnimationDirection.in_]
enum AnimationDirection {
  /// [AnimationDirection.inAndOut] makes both the entering page and the exiting page animate.
  inAndOut,

  /// [AnimationDirection.in_] makes the exiting page animate but not the entering one.
  in_,

  /// [AnimationDirection.out] makes the entering page animate but not the exiting one.
  out
}

/// Carries information about page transitions when bottom navbar items are navigated.
class PageTransitionData {
  final AnimatedBuilderBuilder builder;
  final int duration;
  final AnimationDirection direction;

  PageTransitionData({
    required this.builder,
    this.duration = 150,
    this.direction = AnimationDirection.inAndOut,
  });
}

/// Improvement over the framework [IndexedStack] widget.
/// Allows the switching widgets to animate in and out.
///
/// Credit: https://gist.github.com/cirnok/e1b70f5d841e47c9d85ccdf6ae866984
class TwoWayAnimatedIndexedStack extends StatefulWidget {
  /// Currently selected page index.
  final int index;

  /// The pages shown and animated.
  final List<Widget> children;

  /// A function that builds the required [AnimatedBuilder]
  final PageTransitionData animData;

  const TwoWayAnimatedIndexedStack({
    Key? key,
    required this.index,
    required this.children,
    required this.animData,
  }) : super(key: key);

  @override
  _TwoWayAnimatedIndexedStackState createState() =>
      _TwoWayAnimatedIndexedStackState();
}

class _TwoWayAnimatedIndexedStackState extends State<TwoWayAnimatedIndexedStack>
    with SingleTickerProviderStateMixin {
  /// Page transition animation controller.
  late AnimationController _controller = AnimationController(
    duration: Duration(milliseconds: widget.animData.duration),
    vsync: this,
  );

  /// Index that keeps track of current page during the animation.
  int _index = 0;

  @override
  void initState() {
    _index = widget.index;

    // Animate the page on initialization.
    if (widget.animData.direction == AnimationDirection.out)
      _controller.value = 1;
    else
      _controller.forward();

    super.initState();
  }

  @override
  void didUpdateWidget(TwoWayAnimatedIndexedStack oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Animate the page on update.
    if (widget.index != _index) {
      if (widget.animData.direction == AnimationDirection.inAndOut) {
        // Animate out
        _controller.reverse().then((_) {
          setState(() => _index = widget.index);
          // Then animate in
          _controller.forward();
        });
      } else if (widget.animData.direction == AnimationDirection.in_) {
        setState(() => _index = widget.index);
        // Jump out and animate in.
        _controller.forward(from: 0);
      } else if (widget.animData.direction == AnimationDirection.out) {
        // Animate out
        _controller.reverse().then((_) {
          // Then jump in
          setState(() => _index = widget.index);
          _controller.value = 1;
        });
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.animData.builder(
      _controller,
      IndexedStack(
        index: _index,
        children: widget.children,
      ),
    );
  }
}
