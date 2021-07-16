![bottom_nav_layout](https://user-images.githubusercontent.com/32205084/124828867-8380db00-df80-11eb-859e-7a087ef8073b.png)

---

<img align="right" src="https://user-images.githubusercontent.com/32205084/125892687-a4c3549b-5980-447b-b80a-2ce355c04f49.gif">

![stack_gif](https://user-images.githubusercontent.com/32205084/125892907-c5bb50e7-1d3e-409b-b588-8fb4f4e0fb2a.gif)

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

### What is `bottom_nav_layout`?
It is a quick flutter app layout for building an app with a bottom nav bar. You can get an app with fluent behavior running in 15 lines of code.

### Why `bottom_nav_layout`?
 - Eliminates all boilerplate code for bottom nav bar coordination.
 - Uses identical APIs with the underlying bottom bars.
 - Offers additional common features, all of which are optional.
   - Page state preservation
   - Lazy page loading
   - Navigation management
 - Works with any bottom bar you wish. Use the material desing, grab one from pub.dev or use your own.

# Content
 - [Usage](#usage)
 - [Page State Preservation](#page-state-preservation)
 - [Lazy Page Loading](#lazy-page-loading)
 - [Page Back Stack](#page-back-stack)
 - [In-Page Navigation](#in-page-navigation)
 - [Different Bottom Bars](#different-bottom-bars)
 - [Improvements](#improvements)
 - [Community](#community)

# Usage
## Installation
Add the following to your `pubspec.yaml` file.
```yaml
dependencies:
  bottom_nav_layout: latest_version
```

## Quick Start Example
```dart
import 'package:bottom_nav_layout/bottom_nav_layout.dart';

void main() => runApp(MaterialApp(
      home: BottomNavLayout(
        // The app's destinations
        pages: [
          (_) => Center(child: Text("Welcome to bottom_nav_layout")),
          (_) => SliderPage(),
          (_) => Center(child: TextField(decoration: InputDecoration(hintText: 'Go..'))),
        ],
        bottomNavigationBar: (currentIndex, onTap) => BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) => onTap(index),
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

[SliderPage code](https://github.com/m-azyoksul/bottom_nav_layout/blob/feature_bottom_bar_predicate/example/lib/pages/slider_page.dart)

## Parameters
| Name | Description | Default |
| :--- | :--- | :--- |
| `pages` | The app's destinations. | N/A |
| `bottomNavigationBar` | The bottom navbar of the layout. | N/A |
| `savePageState` | When false, the pages are reinitialized every time they are navigated. (Material behavior). When true, the pages are initialized once and hidden/shown on navigation. (Cupertino behavior) | false |
| `lazyLoadPages` | When false, pages are created in the beginning. When true, pages are created when they are navigated for the first time. | false |
| `pageStack` | Navigation stack that remembers pages visited. Enhances back button management on Android. | ReorderToFrontPageStack for Android, NoPageStack for iOS |
| `extendBody` | Passed to [`Scaffold.extendBody`](https://api.flutter.dev/flutter/material/Scaffold/extendBody.html). | false |
| `resizeToAvoidBottomInset` | Passed to [`Scaffold.resizeToAvoidBottomInset`](https://api.flutter.dev/flutter/material/Scaffold/resizeToAvoidBottomInset.html). | true |

## Inner Widget Tree
![inner_widget_tree](https://user-images.githubusercontent.com/32205084/125547934-389fa034-02dd-4398-9a96-5cc96fd1b762.jpg)

</br>

![image](https://user-images.githubusercontent.com/32205084/124861906-1f303c80-dfbd-11eb-8525-00ad827d9a32.png)

# Page State Preservation
The state changes you made in a page such as scroll amount, sub-navigation, form inputs etc. are preserved. You can enable it as per [Cupertino Design Guidelines](https://developer.apple.com/design/human-interface-guidelines/ios/app-architecture/navigation/) or disable it as per [Material Design Guidelines](https://material.io/components/bottom-navigation#behavior)
```dart
savePageState: true, // Default is false
```

# Lazy Page Loading
The layout offers the option to lazily create the pages using the passed in page builders. When `lazyLoadPages` is set to true, the pages are not created until they are navigated to for the first time. This is useful when a non-initial page;
 - Has a load animation.
 - Runs a heavy process that is not needed until the page is opened.
 ```dart
 lazyLoadPages: true, // Default is false
 ```

# Page Back Stack
The layout remembers the order of pages navigated and when back button is pressed, navigates back to the previously navigated page.

There are many useful page back stack behaviors implemented such as reorder-to-front and replace-except-first. You can also implement your own.

You also specify the `initialPage` inside `PageStack`.

```dart
// Default is ReorderToFrontPageStack for Android and NoPageStack for iOS.
pageStack: ReorderToFrontPageStack(initialPage: 0),
```

[Page Back Stack Documentation](https://github.com/m-azyoksul/bottom_nav_layout/tree/main/docs/PageBackStack) for details.

# In-Page Navigation
The layout can manage [flat navigation pattern](https://developer.apple.com/design/human-interface-guidelines/ios/app-architecture/navigation/).

<p align="center">
  <img src="https://user-images.githubusercontent.com/32205084/125260520-1024f380-e309-11eb-8c2d-4b10fc3dbc41.png">
 <br/>
  <i>Figure: Flat Navigation</i>
</p>

Benefits
 1. Android back button navigates both in-page and among pages.
 2. Bottom bar pops all in-page stack when the current bar item is reselected.

To do this, the page should have a `Navigator` widget that use the passed in `GlobalKey` as its key.

[In-Page Navigation Documentation](https://github.com/m-azyoksul/bottom_nav_layout/tree/main/docs/InPageNavigation) for more information.

# Different Bottom Bars
So far, we only worked on Material bottom nav bar. The layout supports any bottom bar.

Example usage of [`flutter_snake_navigationbar`](https://pub.dev/packages/flutter_snake_navigationbar):

```dart
bottomNavigationBar: (currentIndex, onTap) => SnakeNavigationBar.color(
  currentIndex: currentIndex,
  onTap: (index) => onTap(index),
  items: [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(Icons.linear_scale), label: 'Slider'),
    BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
  ],
),
```

# Improvements
 - I am planning to add page transition animations.
 - Tell me if you want to see a feature your app has/needs in this package. I will do my best to integrate it.
 - I am also considering to make a drawer_nav_layout package. If you are interested, let me know!

# Community
Any feedback is appreciated. 🚀🚀

I love talking about code. Find me on discord at ViraL#2868

If you have queries, feel free to create an [issue](https://github.com/m-azyoksul/bottom_nav_layout/issues).

If you would like to contribute, feel free to create a [PR](https://github.com/m-azyoksul/bottom_nav_layout/pulls).
