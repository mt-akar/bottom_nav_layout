![bottom_nav_layout](https://user-images.githubusercontent.com/32205084/124828867-8380db00-df80-11eb-859e-7a087ef8073b.png)
======
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

`bottom_nav_layout` is a quick flutter app layout for building an app with a bottom nav bar. You can get an app with fluent behavior running in seconds.

### Why `bottom_nav_layout`?
 - Eliminates all boilerplate code for bottom nav bar coordination.
 - Supports multiple, beautiful bar designs.
 - Uses identical APIs with the underlying bottom bars.
 - Offers additional common features. All of them are optional.
   - Page state preservation
   - Lazy page loading
   - Page backstack
   - Back button navigation management
   - Bar Styling

# Content
 - [Usage](#usage)
 - [Page State Preservation](#page-state-preservation)
 - [Lazy Page Loading](#lazy-page-loading)
 - [Page Back Stack](#page-back-stack)
 - [In-Page Navigation Using GlobalKeys](#in-page-navigation-using-globalkeys)
 - [Different Bar Designs](#different-bar-designs)
 - [Bar Styling](#bar-styling)
 - [Improvements](#improvements)

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
          Center(child: TextField(decoration: InputDecoration(hintText: 'Go...'))),
        ],
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.linear_scale), label: 'Slider'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
        ],
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
 - `pages` - Top level destinations of your application.
 - `pageBuilders` - Also top level destinations but can be lazily loaded.
 - `savePageState` - Flag to enable/disable saving page state.
 - `pageStack` - Navigation stack that remembers pages visited.
 - `keys` - Keys that help the layout manage in-page navigation.
 - `bottomBarStyler` - Widget that wrap bottom bar.
 - Rest of the parameters such as `items`, `selectedItemColor`, `elevation` etc. are used to construct the bottom bar. The layout uses flutter's `BottomNavigationBar` under the hood. The API is identical (except `currentIndex`, which is same as `pageStack.peek()`).

</br>

![image](https://user-images.githubusercontent.com/32205084/124861906-1f303c80-dfbd-11eb-8525-00ad827d9a32.png)

# Page State Preservation
The state changes you made in a page such as scroll amount, sub-navigation, form inputs etc. are preserved. You can enable it as per [Cupertino Design Guidelines](https://developer.apple.com/design/human-interface-guidelines/ios/app-architecture/navigation/) or disable it as per [Material Design Guidelines](https://material.io/components/bottom-navigation#behavior)
```dart
BottomNavLayout(
  // ...
  savePageState: true, // Default is true
)
```

# Lazy Page Loading
Instead of passing `pages`, pass `pageBuilders`.

`pageBuilders` are simple Functions that immediately return the corresponding page. When used, the pages are not created until they are navigated to for the first time. This is useful when a non-initial page has a load animation or runs an unnecessary heavy process.
```dart
BottomNavLayout(
  // ...
  pageBuilders: [
    () => Center(child: Text("Welcome to bottom_nav_layout")),
    () => GamePage('TicTacToe'),
    () => Center(child: TextField(decoration: InputDecoration(hintText: 'Search...'))),
  ],
)
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

### ReplacePageStack
This behavior is the same as the behavior in [`BottomNavigationBar` example given in flutter docs](https://api.flutter.dev/flutter/material/BottomNavigationBar-class.html). It is used by a lot of applications. It is also both Cupertino's and Material's default behavior.

| Event | Initial | push(1) | push(2) | push(1) | pop() | push(0) | pop() |
| ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- |
| Stack | 0 | 1 | 2 | 1 | Exit App | N/A | N/A |

### ReplaceExceptFirstPageStack
This behavior is used by Google, Gmail, Facebook, and Twitter apps.

| Event | Initial | push(1) | push(2) | push(1) | pop() | push(0) | pop() |
| ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- |
| Stack | 0 | 0->1 | 0->2 | 0->1 | 0 | 0 | Exit App |

## Using Page Stacks

```dart
BottomNavLayout(
  // ...
  pageStack: StandardPageStack(initialPage: 0),
  // pageStack: ReorderToFrontPageStack(initialPage: 0),
  // pageStack: ReplacePageStack(initialPage: 0),
  // pageStack: ReplaceExceptFirstPageStack(initialPage: 0),
  // pageStack: ReorderToFrontExceptFirstPageStack(initialPage: 0),
)
```

# In-Page Navigation Using GlobalKeys
To be filled...

To use keys, pass all the keys you passed to the pages in the same order.
```dart
BottomNavLayout(
  // ...
  keys: <GlobalKey<NavigatorState>?>[
    homePageKey,
    null, // If a page doesn't use a key, pass null so that layout knows the order.
    placePageKey,
  ],
)
```

# Different Bar Designs
So far, we only worked on Material design bottom nav bar. The layout also supports other bar designs.

## Salomon Bottom Bar
It is possible to use [salomon_bottom_bar](https://pub.dev/packages/salomon_bottom_bar#salomon_bottom_bar) with the layout.

Add the following to your `pubspac.yaml` file.
```yaml
salomon_bottom_bar: latest_version
```

And use the following quick start example.
```dart
void main() => runApp(MaterialApp(
      home: SalomonBottomNavLayout(
        // The app's top level destinations
        pages: [
          Center(child: Text("Welcome to bottom_nav_layout")),
          GamePage('TicTacToe'),
          Center(child: TextField(decoration: InputDecoration(hintText: 'Search...'))),
        ],
        items: [
          SalomonBottomBarItem(icon: Icon(Icons.home), title: Text('Home')),
          SalomonBottomBarItem(icon: Icon(Icons.gamepad), title: Text('Game')),
          SalomonBottomBarItem(icon: Icon(Icons.search), title: Text('Search')),
        ],
      ),
    ));
```

# Bar Styling
### Extend Body
You can have the page extend behind the bottom bar.
```dart
BottomNavLayout(
  // ...
  extendBody: true,
)
```

### Bar Styler
Do you not like how your bottom bar looks? You can style it by wrapping it inside any widget.
```dart
BottomNavLayout(
  // ...
  bottomBarStyler: (bottomBar) => Padding(
    padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
    child: bottomBar,
  ),
)
```

# Improvements
I am looking to improve this package. Any feedback is appreciated. 🚀🚀

If you have queries, feel free to create an [issue](https://github.com/m-azyoksul/bottom_nav_layout/issues).

If you would like to contribute, feel free to create a [PR](https://github.com/m-azyoksul/bottom_nav_layout/pulls).
