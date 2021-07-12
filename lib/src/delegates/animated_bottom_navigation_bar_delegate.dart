// animated_bottom_navigation_bar is not compatible because it uses a parent Scaffold's parameters to render itself.

// import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
// import 'package:flutter/material.dart';
//
// import '../nav_bar_delegate.dart';
// import '../layout.dart';
//
// /// This class contains parameters used to create a [AnimatedBottomNavigationBar] instance, except [AnimatedBottomNavigationBar.activeIndex]
// /// which is encapsulated in [BottomNavLayout.pageStack]
// ///
// /// Check out the documentation for [AnimatedBottomNavigationBar]
// /// https://pub.dev/packages/animated_bottom_navigation_bar
// class AnimatedBottomNavigationBarDelegate extends NavBarDelegate {
//   AnimatedBottomNavigationBarDelegate({
//     this.key,
//     required this.icons,
//     required this.onTap,
//     this.height,
//     this.elevation,
//     this.splashRadius = 24,
//     this.splashSpeedInMilliseconds,
//     this.notchMargin,
//     this.backgroundColor,
//     this.splashColor,
//     this.activeColor,
//     this.inactiveColor,
//     this.notchAndCornersAnimation,
//     this.leftCornerRadius,
//     this.rightCornerRadius,
//     this.iconSize,
//     this.notchSmoothness,
//     this.gapLocation,
//     this.gapWidth,
//   });
//
//   final Key? key;
//   final List<IconData> icons;
//   final Function(int) onTap;
//   final double? height;
//   final double? elevation;
//   final double splashRadius;
//   final int? splashSpeedInMilliseconds;
//   final double? notchMargin;
//   final Color? backgroundColor;
//   final Color? splashColor;
//   final Color? activeColor;
//   final Color? inactiveColor;
//   final Animation<double>? notchAndCornersAnimation;
//   final double? leftCornerRadius;
//   final double? rightCornerRadius;
//   final double? iconSize;
//   final NotchSmoothness? notchSmoothness;
//   final GapLocation? gapLocation;
//   final double? gapWidth;
//
//   Widget createBar(pageStackPeek, void Function(int) onPageSelected) {
//     return AnimatedBottomNavigationBar(
//       key: key,
//       icons: icons,
//       activeIndex: pageStackPeek,
//       onTap: (index) {
//         // Layout functionality
//         onPageSelected(index);
//
//         // Passed in onTap call
//         onTap.call(index);
//       },
//       height: height,
//       elevation: elevation,
//       splashRadius: splashRadius,
//       splashSpeedInMilliseconds: splashSpeedInMilliseconds,
//       notchMargin: notchMargin,
//       backgroundColor: backgroundColor,
//       splashColor: splashColor,
//       activeColor: activeColor,
//       inactiveColor: inactiveColor,
//       notchAndCornersAnimation: notchAndCornersAnimation,
//       leftCornerRadius: leftCornerRadius,
//       rightCornerRadius: rightCornerRadius,
//       iconSize: iconSize,
//       notchSmoothness: notchSmoothness,
//       gapLocation: gapLocation,
//       gapWidth: gapWidth,
//     );
//   }
//
//   @override
//   int itemLength() {
//     return icons.length;
//   }
// }
