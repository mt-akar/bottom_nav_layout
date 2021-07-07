# What is `bottom_nav_layout`?
It is quick and powerful layout with
 - Bottom nav bar and pages
 - Page state preservation
 - Lazy page loading
 - Page backstack

If you don't want to deal with boilerplate code that coordinates bottom nav bar and app's top level destinations, you should use `bottom_nav_layout`.

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
  // The app's top level destinations
  pages: [
    Center(child: Text("Welcome to bottom_nav_layout")),
    ExamplePage('Music'),
    ExamplePage('Place'),
    Center(child: TextField(decoration: InputDecoration(hintText: 'Enter search term...'))),
  ],
  // Delegates its properties to a flutter BottomNavigationBar
  bottomNavBarDelegate: BottomNavBarDelegate(
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
  ),
)
```

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
This layout remembers the order of pages navigated and when back button is pressed, navigates back to the previously navigated page. There are different ways of organizing a page back stack, many of which are readily implemented. You can also implement your own.

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
To be filled.
