import 'package:flutter/widgets.dart';

import '../../bottom_nav_layout.dart';

class PrebuiltAnimationBuilderBuilders {
  /// Previous page zooms in and fades out,
  /// next page zooms out and fades in.
  static AnimatedBuilderBuilder zoomInAndFadeOut =
      (controller, child) => AnimatedBuilder(
            animation: Tween(begin: 0.0, end: 1.0).animate(controller),
            builder: (context, child) => Opacity(
              opacity: controller.value,
              child: Transform.scale(
                scale: 1.05 - (controller.value * 0.05),
                child: child,
              ),
            ),
            child: child,
          );

  /// Previous page fades out,
  /// next page fades in.
  static AnimatedBuilderBuilder fadeOut =
      (controller, child) => AnimatedBuilder(
            animation: Tween(begin: 0.0, end: 1.0).animate(controller),
            builder: (context, child) => Opacity(
              opacity: controller.value,
              child: child,
            ),
            child: child,
          );

//
// More preset builders can be added here.
//
}
