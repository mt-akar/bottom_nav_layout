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
| `extendBody` | Passed to [`Scaffold.extendBody`](https://api.flutter.dev/flutter/material/Scaffold/extendBody.html). |
| `resizeToAvoidBottomInset` | Passed to [`Scaffold.resizeToAvoidBottomInset`](https://api.flutter.dev/flutter/material/Scaffold/resizeToAvoidBottomInset.html). |
| `navBarDelegate` | Properties passed into it such as `items`, `onTap`, `elevation`, etc. are used to construct the underlying bottom bar. |

## Inner Widget Tree
![inner_widget_tree](https://user-images.githubusercontent.com/32205084/125547934-389fa034-02dd-4398-9a96-5cc96fd1b762.jpg)

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

If `savePageState` is set to false, `pages` and `pageBuilders` do the same thing.

# Page Back Stack
The layout remembers the order of pages navigated and when back button is pressed, navigates back to the previously navigated page.

You also specify the `initialPage` from here.

```dart
// Default is ReorderToFrontPageStack for Android and NoPageStack for iOS.
pageStack: ReorderToFrontPageStack(initialPage: 0),
```

See [Page Back Stack Documentation](https://github.com/m-azyoksul/bottom_nav_layout/blob/main/docs/PageBackStack/README.md) for more information on page back stack.

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
So far, we only worked on Material bottom nav bar. The layout also supports any bottom bar.

Example usage of [flutter_snake_navigationbar](https://pub.dev/packages/flutter_snake_navigationbar):

```dart
bottomNavigationBar: (currentIndex, onTap) => SnakeNavigationBar.color(
  currentIndex: currentIndex,
  onTap: onTap,
  items: [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(Icons.linear_scale), label: 'Slider'),
    BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
  ],
),
```


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
