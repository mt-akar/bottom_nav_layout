// Passing the context parameter deterred me from adding this design

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
//
// import '../layout.dart';
// import '../nav_bar_delegate.dart';
//
// /// This class contains parameters used to create a [PersistentTabView] instance,
// /// except the parameters that provide layout functionality.
// ///
// /// Check out the documentation for [PersistentTabView].
// /// https://pub.dev/packages/persistent_bottom_nav_bar
// class PersistentTabViewDelegate extends NavBarDelegate {
//   final Key? key;
//   final double navBarHeight;
//   final margin;
//   final backgroundColor;
//   final ValueChanged<int>? onItemSelected;
//   final NeumorphicProperties? neumorphicProperties;
//   final NavBarPadding padding;
//   final NavBarDecoration decoration;
//   final ItemAnimationProperties? itemAnimationProperties;
//   final NavBarStyle navBarStyle;
//
//   PersistentTabViewDelegate({
//     this.key,
//     this.navBarHeight = kBottomNavigationBarHeight,
//     this.margin = EdgeInsets.zero,
//     this.backgroundColor = CupertinoColors.white,
//     this.onItemSelected,
//     this.neumorphicProperties,
//     this.padding = const NavBarPadding.all(null),
//     this.decoration = const NavBarDecoration(),
//     this.itemAnimationProperties,
//     this.navBarStyle = NavBarStyle.style1,
//   });
//
//   Widget createBar(int pageStackPeek, void Function(int) onPageSelected) {
//     return PersistentTabView(
//       context,
//       key:key,
//       navBarHeight:navBarHeight,
//       margin :margin,
//       backgroundColor:backgroundColor,
//       onItemSelected:(index) {
//         // Layout functionality
//         onPageSelected(index);
//
//         // Passed in onTap call
//         onItemSelected?.call(index);
//       },
//       neumorphicProperties:neumorphicProperties,
//       padding :padding,
//       decoration :decoration,
//       itemAnimationProperties:itemAnimationProperties,
//       navBarStyle :navBarStyle,
//       screens: [],
//     );
//   }
//
//   @override
//   int itemLength() {
//     return items.length;
//   }
// }
