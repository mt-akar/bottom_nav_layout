![bottom_nav_layout](https://user-images.githubusercontent.com/32205084/124828867-8380db00-df80-11eb-859e-7a087ef8073b.png)
======
<img align="right" src="https://user-images.githubusercontent.com/32205084/124965664-0cece780-e02b-11eb-8cb9-493ee24941a0.gif">

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

### What is `bottom_nav_layout`?
It is a quick flutter app layout for building an app with a bottom nav bar. You can get an app with fluent behavior running in 15 lines of code.

### Why `bottom_nav_layout`?
 - Eliminates all boilerplate code for bottom nav bar coordination.
 - Uses identical APIs with the underlying bottom bars.
 - Offers additional common features, all of which are optional.
   - Page state preservation
   - Lazy page loading
   - Page backstack
   - Back button navigation management
 - Works with any bottom bar you wish. Use the material desing, grab one from pub.dev or use your own.

# Content
 - [Usage](#usage)
 - [Page State Preservation](#page-state-preservation)
 - [Lazy Page Loading](#lazy-page-loading)
 - [Page Back Stack](#page-back-stack)
 - [In-Page Navigation Using GlobalKeys](#in-page-navigation-using-globalkeys)
 - [Different Bottom Bars](#different-bottom-bars)
 - [Bar Styling](#bar-styling)
 - [Improvements](#improvements)
 - [Community](#community)

# Usage
## Installation
Add the following to your `pubspec.yaml` file.
```yaml
dependencies:
  bottom_nav_layout: latest_version
```

## Import
```dart
import 'package:bottom_nav_layout/bottom_nav_layout.dart';
```

## Quick Start Example
```dart
void main() => runApp(MaterialApp(
      home: BottomNavLayout(
        // The app's top level destinations
        pages: [
          Center(child: Text("Welcome to bottom_nav_layout")),
          SliderPage(),
          Center(child: TextField(decoration: InputDecoration(hintText: 'Search...'))),
        ],
        
        // Delegates its properties to a BottomNavigationBar.
        navBarDelegate: BottomNavigationBarDelegate(
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.linear_scale), label: 'Slider'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          ],
        ),
      ),
    ));
```
Done. You have a complete, working application.
 
<details>
<summary>SliderPage code</summary>
<p>

```dart
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
```
</p>
</details>  

## Parameters
| Name | Description |
| :--- | :--- |
| `pages` | Top level destinations of your application. |
| `pageBuilders` | Also top level destinations but can be lazily loaded. |
| `savePageState` | Flag to enable/disable saving page state. |
| `pageStack` | Navigation stack that remembers pages visited. Enhances back button management on Android. |
| `keys` | Keys that help the layout manage in-page navigation. |
| `bottomBarWrapper` | Widget that wrap bottom bar. |
| `extendBody` | Passed to `Scaffold.extendBody`. |
| `resizeToAvoidBottomInset` | Passed to `Scaffold.resizeToAvoidBottomInset`. |
| `navBarDelegate` | Properties passed into it such as `items`, `onTap`, `elevation`, etc. are used to construct the underlying bottom bar. |

## Inner Widget Tree

![Untitled Diagram (2)](https://user-images.githubusercontent.com/32205084/125398466-04443a80-e3b8-11eb-86a4-90c50d45a1fb.png)

</br>

![image](https://user-images.githubusercontent.com/32205084/124861906-1f303c80-dfbd-11eb-8525-00ad827d9a32.png)

# Page State Preservation
The state changes you made in a page such as scroll amount, sub-navigation, form inputs etc. are preserved. You can enable it as per [Cupertino Design Guidelines](https://developer.apple.com/design/human-interface-guidelines/ios/app-architecture/navigation/) or disable it as per [Material Design Guidelines](https://material.io/components/bottom-navigation#behavior)
```dart
savePageState: true, // Default is true
```

# Lazy Page Loading
Instead of passing `pages`, pass `pageBuilders`.

`pageBuilders` are simple Functions that immediately return the corresponding page. When used, the pages are not created until they are navigated to for the first time. This is useful when a non-initial page has a load animation or runs an unnecessary heavy process.
```dart
pageBuilders: [
  () => Center(child: Text("Welcome to bottom_nav_layout")),
  () => GamePage('TicTacToe'),
  () => Center(child: TextField(decoration: InputDecoration(hintText: 'Search...'))),
],
```

# Page Back Stack
The layout remembers the order of pages navigated and when back button is pressed, navigates back to the previously navigated page. There are different ways of organizing a page back stack, many of which are readily implemented. You can also implement your own.

## Page Back Stack Types

Consider the following use case. After launching the app, the user;
 - Start at page 0
 - Navigate to page 1
 - Navigate to page 2
 - Navigate to page 1
 - Press back button
 - Navigate to page 0
 - Press back button

Let's look at how different PageStacks behave in this scenario.

### StandardPageStack
This behavior is used by Google Play app.

| Event | Initial | push(1) | push(2) | push(1) | pop() | push(0) | pop() |
| ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- |
| Stack | 0 | 0->1 | 0->1->2 | 0->1->2->1 | 0->1->2 | 0->1->2->0 | 0->1->2 |

### ReorderToFrontPageStack
This is the default behavior. This behavior is used by Instagram, Reddit, and Netflix apps.

| Event | Initial | push(1) | push(2) | push(1) | pop() | push(0) | pop() |
| ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- |
| Stack | 0 | 0->1 | 0->1->2 | 0->2->1 | 0->2 | 2->0 | 2 |

### ReorderToFrontExceptFirstPageStack
This behavior is used by Youtube app.

| Event | Initial | push(1) | push(2) | push(1) | pop() | push(0) | pop() |
| ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- |
| Stack | 0 | 0->1 | 0->1->2 | 0->2->1 | 0->2 | 0->2->0 | 0->2 |

### NoPageStack
This behavior is the same as the behavior in [`BottomNavigationBar` example given in flutter docs](https://api.flutter.dev/flutter/material/BottomNavigationBar-class.html). It is used by a lot of applications. It is also both Cupertino's and Material's default behavior.

| Event | Initial | push(1) | push(2) | push(1) | pop() | push(0) | pop() |
| ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- |
| Stack | 0 | 1 | 2 | 1 | Exit App | N/A | N/A |

### FirstAndLastPageStack
This behavior is used by Google, Gmail, Facebook, and Twitter apps.

| Event | Initial | push(1) | push(2) | push(1) | pop() | push(0) | pop() |
| ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- |
| Stack | 0 | 0->1 | 0->2 | 0->1 | 0 | 0 | Exit App |

## Using Page Stacks

```dart
pageStack: ReorderToFrontPageStack(initialPage: 0), // Default
// pageStack: StandardPageStack(initialPage: 0),
// pageStack: ReorderToFrontExceptFirstPageStack(initialPage: 0),
// pageStack: NoPageStack(initialPage: 0),
// pageStack: FirstAndLastPageStack(initialPage: 0),
```

# In-Page Navigation Using GlobalKeys

<p align="center">
  <img src="https://user-images.githubusercontent.com/32205084/125260520-1024f380-e309-11eb-8c2d-4b10fc3dbc41.png">
 <br/>
  <i>Figure: Flat Navigation</i>
</p>

 1. Allows the layout to manage a [flat navigation pattern](https://developer.apple.com/design/human-interface-guidelines/ios/app-architecture/navigation/).
 2. Let's us go back to the root route, when the bottom bar item on the current index is selected again.

To do this, the page should have a `Navigator` widget and the same instance of the key should be used as the `Navigator`'s key in the corresponding page.

Example code to be added here...

To use keys, pass all the keys you passed to the pages in the same order.
```dart
keys: <GlobalKey<NavigatorState>?>[
  homePageKey,
  null, // If a page doesn't use a key, pass null so that layout knows the order
  placePageKey,
],
```

# Different Bottom Bars
So far, we only worked on Material design bottom nav bar. The layout also supports other bar designs. To use the design you want, pass the corresponding `navBarDelegate` to the layout.

The `navBarDelegate`'s APIs are all identical with the respective packages. You will need to <b>import the corresponding bottom bar package</b> to be able to pass some of the parameters. Make sure to check out their documentation before using.

Warning: Some of the packages' index constructor parameter acts as an `initialIndex`, not as a `currentIndex`, therefore, selected item cannot be changed when the back button is pressed. To have the best result, only use `NoPageStack` with bottom bars that doesn't have the `currentIndex` property.

## 1. Material

| Documentation | NavBarDelegate | Has `currentIndex` |
| :------------ | :------------- | :------------- |
| [BottomNavigationBar](https://api.flutter.dev/flutter/material/BottomNavigationBar-class.html) | `BottomNavigationBarDelegate` | Yes |

## 2. convex_bottom_bar

| Documentation | NavBarDelegate | Has `currentIndex` |
| :------------ | :------------- | :------------- |
| [convex_bottom_bar](https://pub.dev/packages/convex_bottom_bar) | `ConvexAppBarDelegate` | No |

Example:

```dart
 navBarDelegate: ConvexAppBarDelegate(
   items: [
     TabItem(icon: Icon(Icons.home), title: 'Home'),
     TabItem(icon: Icon(Icons.linear_scale), title: 'Slider'),
     TabItem(icon: Icon(Icons.search), title: 'Search'),
   ],
 ),
```

## 3. flutter_snake_navigationbar

| Documentation | NavBarDelegate | Has `currentIndex` |
| :------------ | :------------- | :------------- |
| [flutter_snake_navigationbar](https://pub.dev/packages/flutter_snake_navigationbar) | `SnakeNavigationBarDelegate` | Yes |

Example:

```dart
navBarDelegate: SnakeNavigationBarDelegate(
  items: [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(Icons.linear_scale), label: 'Slider'),
    BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
  ],
  height: 56,
),
```

## 4. salomon_bottom_bar

| Documentation | NavBarDelegate | Has `currentIndex` |
| :------------ | :------------- | :------------- |
| [salomon_bottom_bar](https://pub.dev/packages/salomon_bottom_bar) | `SalomonBottomBarDelegate` | Yes |

Example:

```dart
navBarDelegate: SalomonBottomBarDelegate(
  items: [
    SalomonBottomBarItem(icon: Icon(Icons.home), title: Text('Home')),
    SalomonBottomBarItem(icon: Icon(Icons.linear_scale), title: Text('Slider')),
    SalomonBottomBarItem(icon: Icon(Icons.search), title: Text('Search')),
  ],
),
```

## 5. bottom_bar_with_sheet

| Documentation | NavBarDelegate | Has `currentIndex` |
| :------------ | :------------- | :------------- |
| [bottom_bar_with_sheet](https://pub.dev/packages/bottom_bar_with_sheet) | `BottomBarWithSheetDelegate` | No |

Example:

```dart
navBarDelegate: BottomBarWithSheetDelegate(
  items: [
    BottomBarWithSheetItem(icon: Icons.home),
    BottomBarWithSheetItem(icon: Icons.linear_scale),
    BottomBarWithSheetItem(icon: Icons.linear_scale),
    BottomBarWithSheetItem(icon: Icons.search),
  ],
  sheetChild: Center(child: Text("Welcome to sheetChild")),
),
```

## 6. water_drop_nav_bar

| Documentation | NavBarDelegate | Has `currentIndex` |
| :------------ | :------------- | :------------- |
| [water_drop_nav_bar](https://pub.dev/packages/water_drop_nav_bar) | `WaterDropNavBarDelegate` | Yes |

Example:

```dart
navBarDelegate: WaterDropNavBarDelegate(
  barItems: [
    BarItem(filledIcon: Icons.home_filled, outlinedIcon: Icons.home_outlined),
    BarItem(filledIcon: Icons.linear_scale, outlinedIcon: Icons.linear_scale_outlined),
    BarItem(filledIcon: Icons.search, outlinedIcon: Icons.search),
  ],
),
```

## 7. sliding_clipped_nav_bar

| Documentation | NavBarDelegate | Has `currentIndex` |
| :------------ | :------------- | :------------- |
| [sliding_clipped_nav_bar](https://pub.dev/packages/sliding_clipped_nav_bar) | `SlidingClippedNavBarDelegate` | Yes |

Example:

```dart
navBarDelegate: SlidingClippedNavBarDelegate(
  barItems: [
    BarItem(icon: Icons.home, title: 'Home'),
    BarItem(icon: Icons.linear_scale, title: 'Slider'),
    BarItem(icon: Icons.search, title: 'Search'),
  ],
  activeColor: Colors.blue,
),
```

## Other Bar Designs
You can use any bottom bar design from pub.dev or create your own. To do this:

 - Extend `NavBarDelegate` class .
 - Pass an instance to `BottomNavLayout.navBarDelegate`.

Incompatible Packages:

 - [persistent_bottom_nav_bar](https://pub.dev/packages/persistent_bottom_nav_bar): Already a layout package
 - [animated_bottom_navigation_bar](https://pub.dev/packages/animated_bottom_navigation_bar): Uses a parent `Scaffold`'s properties to render.

# Bar Styling
### Bar Wrapper
Do you not like how your bottom bar looks? You can style it by wrapping it inside any widget.
```dart
bottomBarWrapper: (bottomBar) => Padding(
  padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
  child: bottomBar,
),
```

### Extend Body
You can have the page extend behind the bottom bar.
```dart
extendBody: true,
```

# Improvements
 - I am planning to add more bottom bar designs, preferably from pub.dev.
 - Tell me if you want to see a feature your app has/needs in this package. I will do my best to integrate that.
 - I am also considering to make a drawer_nav_layout package. If you are interested, let me know!

# Community
Any feedback is appreciated. 🚀🚀

If you have queries, feel free to create an [issue](https://github.com/m-azyoksul/bottom_nav_layout/issues).

If you would like to contribute, feel free to create a [PR](https://github.com/m-azyoksul/bottom_nav_layout/pulls).
