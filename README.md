# What is `bottom_nav_layout`?
It is quick and powerful layout with
 - Bottom navigation bar
 - Page state preservation
 - Back button navigation management (for android)
 - Lazy page loading

# Installation
This package hasn't been released. Therefore the installiation is directly from github. Add the following code to your `pubspec.yaml` file.
```yaml
bottom_nav_layout:
  git:
    url: https://github.com/m-azyoksul/bottom_nav_layout.git
    ref: main
```

# Quick Start Example
```dart
BottomNavLayout(
  pages: [
    ExamplePage('Favorite'),
    ExamplePage('Music'),
    ExamplePage('Place'),
    Center(child: TextField(decoration: InputDecoration(hintText: 'Enter search term...'))),
  ],
  // Delegates its properties to a flutter BottomNavigationBar
  bottomNavBarDelegate: BottomNavBarDelegate(
    items: [
      BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorites'),
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
# Different Back Stack Types
This layout remembers the order of pages navitagated and when back button is pressed, navigates back to the previously visited page. There are many ways of organizing a tab back stack, a lot of which are readily implemented. You can also implement your own.

Consider the following scerario. After launching the app, the user;
 - Start at tab 0
 - Navigate to tab 1
 - Navigate to tab 2
 - Navigate to tab 1
 - Press back button
 - Navigate to tab 0
 - Press back button

Let's look at how different TabStacks behave in this scenario.

### StandartTabStack
This behavior is used by Google Play app.

| Event | Initial | push(1) | push(2) | push(1) | pop() | push(0) | pop() |
| ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- |
| Stack | 0 | 0->1 | 0->1->2 | 0->1->2->1 | 0->1->2 | 0->1->2->0 | 0->1->2 |

### ReorderToFrontTabStack
This is the default behavior. This behavior is used by Instagram, Reddit, and Netflix apps.

| Event | Initial | push(1) | push(2) | push(1) | pop() | push(0) | pop() |
| ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- |
| Stack | 0 | 0->1 | 0->1->2 | 0->2->1 | 0->2 | 2->0 | 2 |

### ReorderToFrontExceptFirstTabStack
This behavior is used by Youtube app.

| Event | Initial | push(1) | push(2) | push(1) | pop() | push(0) | pop() |
| ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- |
| Stack | 0 | 0->1 | 0->1->2 | 0->2->1 | 0->2 | 0->2->0 | 0->2 |

### ReplaceTabStack
This is similar to the naive example given at [flutter docs](https://api.flutter.dev/flutter/material/BottomNavigationBar-class.html)

This behavior is used by a lot of applications such as Google Drive, Zoom, Microsoft Teams...

| Event | Initial | push(1) | push(2) | push(1) | pop() | push(0) | pop() |
| ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- |
| Stack | 0 | 1 | 2 | 1 | Exit App | N/A | N/A |

### ReplaceExceptFirstTabStack
This behavior is used by Google, Gmail, Facebook, and Twitter apps.

| Event | Initial | push(1) | push(2) | push(1) | pop() | push(0) | pop() |
| ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- |
| Stack | 0 | 0->1 | 0->2 | 0->1 | 0 | 0 | Exit App |

### Using Different Back Stacks

```dart
BottomNavLayout(
  // ...

  tabStack: StandardTabStack(initialTab: 0),
  // tabStack: ReorderToFrontTabStack(initialTab: 0),
  // tabStack: ReplaceTabStack(initialTab: 0),
  // tabStack: ReplaceExceptFirstTabStack(initialTab: 0),
  // tabStack: ReorderToFrontExceptFirstTabStack(initialTab: 0),
)
```

# Lazy Loading
Instead of passing `pages`, pass `pageBuilders`.

`pageBuilders` are simple Functions that immediately return the corresponding page. When used, the pages are not created until they are navigated to for the first time. This is useful when a non-initial page has a load animation or runs a heavy process.
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
# In-Page Navigation Using GlobalKeys
To be filled.
