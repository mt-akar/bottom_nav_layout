# Different Bottom Bars
It is possible to use any bottom bar with this layout. You can use
 - [Material Design Bottom Bar](https://api.flutter.dev/flutter/material/BottomNavigationBar-class.html).
 - Any bottom bar package from pub.dev
 - Custom implemented bottom bar.

# Usage
Example usages of some of the bottom bars. You can use the ones which aren't here as well.

Warning: Some of the packages' index constructor parameter acts as an `initialIndex`, not as a `currentIndex`, therefore, selected item cannot be changed when the back button is pressed. To have the best result, only use `NoPageStack` with bottom bars that doesn't have the `currentIndex` property.

## 1. Material

| Documentation | Has `currentIndex` |
| :------------ | :------------- |
| [BottomNavigationBar](https://api.flutter.dev/flutter/material/BottomNavigationBar-class.html) | Yes |

Example:

```dart
BottomNavigationBar(
  currentIndex: currentIndex,
  onTap: onTap,
  items: [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    BottomNavigationBarItem(
        icon: Icon(Icons.linear_scale), label: 'Slider'),
    BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
  ],
),
```

## 2. [convex_bottom_bar](https://pub.dev/packages/convex_bottom_bar)

Has `currentIndex`: No

Example:

```dart
ConvexAppBar(
  initialActiveIndex: currentIndex,
  onTap: onTap,
  items: [
    TabItem(icon: Icon(Icons.home), title: 'Home'),
    TabItem(icon: Icon(Icons.linear_scale), title: 'Slider'),
    TabItem(icon: Icon(Icons.search), title: 'Search'),
  ],
),
```

## 3. flutter_snake_navigationbar

| Documentation | Has `currentIndex` |
| :------------ | :------------- |
| [flutter_snake_navigationbar](https://pub.dev/packages/flutter_snake_navigationbar) | Yes |

Example:

```dart
SnakeNavigationBar.color(
  currentIndex: currentIndex,
  onTap: onTap,
  items: [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    BottomNavigationBarItem(
        icon: Icon(Icons.linear_scale), label: 'Slider'),
    BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
  ],
),
```

## 4. salomon_bottom_bar

| Documentation | Has `currentIndex` |
| :------------ | :------------- |
| [salomon_bottom_bar](https://pub.dev/packages/salomon_bottom_bar) | Yes |

Example:

```dart
SalomonBottomBar(
  currentIndex: currentIndex,
  onTap: onTap,
  items: [
    SalomonBottomBarItem(icon: Icon(Icons.home), title: Text('Home')),
    SalomonBottomBarItem(
        icon: Icon(Icons.linear_scale), title: Text('Slider')),
    SalomonBottomBarItem(icon: Icon(Icons.search), title: Text('Search')),
  ],
),
```

## 5. bottom_bar_with_sheet

| Documentation | Has `currentIndex` |
| :------------ | :------------- |
| [bottom_bar_with_sheet](https://pub.dev/packages/bottom_bar_with_sheet) | No |

Example:

```dart
BottomBarWithSheet(
  selectedIndex: currentIndex,
  onSelectItem: onTap,
  items: [
    BottomBarWithSheetItem(icon: Icons.home, label: 'Home'),
    BottomBarWithSheetItem(icon: Icons.linear_scale, label: 'Slider'),
    BottomBarWithSheetItem(icon: Icons.search, label: 'Search'),
  ],
  sheetChild: Center(child: Text("Welcome to sheetChild")),
  bottomBarTheme:
      BottomBarTheme(mainButtonPosition: MainButtonPosition.right),
),
```

## 6. water_drop_nav_bar

| Documentation | Has `currentIndex` |
| :------------ | :------------- |
| [water_drop_nav_bar](https://pub.dev/packages/water_drop_nav_bar) | Yes |

Example:

```dart
WaterDropNavBar(
  selectedIndex: currentIndex,
  onButtonPressed: onTap,
  barItems: [
    BarItem(filledIcon: Icons.home, outlinedIcon: Icons.home),
    BarItem(filledIcon: Icons.maximize, outlinedIcon: Icons.maximize),
    BarItem(filledIcon: Icons.search, outlinedIcon: Icons.search),
  ],
),
```

## 7. sliding_clipped_nav_bar

| Documentation | Has `currentIndex` |
| :------------ | :------------- |
| [sliding_clipped_nav_bar](https://pub.dev/packages/sliding_clipped_nav_bar) | Yes |

Example:

```dart
SlidingClippedNavBar(
  selectedIndex: currentIndex,
  onButtonPressed: onTap,
  barItems: [
    BarItem(icon: Icons.home, title: 'Home'),
    BarItem(icon: Icons.linear_scale, title: 'Slider'),
    BarItem(icon: Icons.search, title: 'Search'),
  ],
  activeColor: Colors.blue,
),
```

## Incompatible Packages
 - [persistent_bottom_nav_bar](https://pub.dev/packages/persistent_bottom_nav_bar): Already a layout package
 - [animated_bottom_navigation_bar](https://pub.dev/packages/animated_bottom_navigation_bar): Uses a parent `Scaffold`'s properties to render.