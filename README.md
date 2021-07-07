![bottom_nav_layout (1)](https://user-images.githubusercontent.com/32205084/124821612-99d66900-df77-11eb-8205-7a6b3e621369.png)
======
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT) [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

### `bottom_nav_layout` offers;
 - Layout with bottom nav bar and pages
 - Page state preservation
 - Lazy page loading
 - Page backstack
 - Back button navigation management
 - Multiple bottom bar designs

### Why `bottom_nav_layout`?
 - Eliminates all boilerplate code for bottom nav bar coordination.
 - Implements additional, common features.
 - Supports multiple bar designs.
 - Uses the same APIs with the underlying bottom bars.

# Content
 - [Installation](#installation)
 - [Quick Start Example](#quick-start-example)
 - [Page State Preservation](#page-state-preservation)
 - [Lazy Page Loading](#lazy-page-loading)
 - [Page Back Stack](#page-back-stack)
 - [In-Page Navigation Using GlobalKeys](#in-page-navigation-using-globalkeys)
 - [Styling Bottom Bar](#styling-bottom-bar)
 - [Improvements](#improvements)

# Installation
This package hasn't been released. Therefore the installation is directly from github. Add the following code to your `pubspec.yaml` file.
```yaml
bottom_nav_layout:
  git:
    url: https://github.com/m-azyoksul/bottom_nav_layout.git
    ref: main
```

# Quick Start Example
```dart
BottomNavLayout(
  // Your app's top level destinations
  pages: [
    Center(child: Text("Welcome to bottom_nav_layout")),
    ExamplePage('Music'),
    ExamplePage('Place'),
    Center(child: TextField(decoration: InputDecoration(hintText: 'Enter search term...'))),
  ],

  // Delegate the following properties to a flutter BottomNavigationBar
  items: [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(Icons.music_note), label: 'Music'),
    BottomNavigationBarItem(icon: Icon(Icons.place), label: 'Places'),
    BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
  ],
  backgroundColor: Colors.blue,
  selectedItemColor: Colors.white,
  unselectedItemColor: Colors.white54,
  type: BottomNavigationBarType.fixed,
)
```
This layout uses flutter's `BottomNavigationBar` under the hood. You don't directly create a `BottomNavigationBar` instance, properties given to `BottomNavLayout` are used to create it. The API is the same (except `currentIndex`, which is captured in `pageStack`).

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
    () => const Center(child: Text("Welcome")),
    () => ExamplePage('Music'),
    () => Center(child: TextField(decoration: InputDecoration(hintText: 'Search for favorite'))),
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

## Using Different Back Stacks

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
    null, // If the a page doesn't use a key, pass null so that layout knows the order.
    placePageKey,
  ],
)
```

# Different Bar Designs
So far, we only worked on Material design bottom nav bar. This layout also supports other bar designs.

## Salomon Bottom Bar
It is possible to use [salomon_bottom_bar](https://pub.dev/packages/salomon_bottom_bar#salomon_bottom_bar) with this package.

Add this to your `pubspac.yaml` file.
```yaml
salomon_bottom_bar: latest_version
```

And use this quick start example.
```dart
SalomonBottomNavLayout(
  // Your app's top level destinations
  pages: [
    Center(child: Text("Welcome to bottom_nav_layout")),
    ExamplePage('Music'),
    ExamplePage('Place'),
    Center(child: TextField(decoration: InputDecoration(hintText: 'Enter search term...'))),
  ],

  // Delegate the following properties to a SalomonBottomBar
  items: [
    SalomonBottomBarItem(icon: Icon(Icons.home), activeIcon: Icon(Icons.landscape), title: Text('Home')),
    SalomonBottomBarItem(icon: Icon(Icons.music_note), activeIcon: Icon(Icons.home), title: Text('Music')),
    SalomonBottomBarItem(icon: Icon(Icons.place), activeIcon: Icon(Icons.insights), title: Text('Places')),
    SalomonBottomBarItem(icon: Icon(Icons.search), activeIcon: Icon(Icons.insights), title: Text('Search')),
  ],
  selectedItemColor: Theme.of(context).primaryColor,
  unselectedItemColor: Colors.grey,
)
```

# Styling Bottom Bar
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
Any feedback is appreciated. 🚀🚀

I am looking to improve this package. If you have any ideas, create an issue.
