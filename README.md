![bottom_nav_layout](https://user-images.githubusercontent.com/32205084/124828867-8380db00-df80-11eb-859e-7a087ef8073b.png)

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![GitHub Repo stars](https://img.shields.io/github/stars/m-azyoksul/bottom_nav_layout?style=social)](https://github.com/m-azyoksul/bottom_nav_layout)
[![GitHub followers](https://img.shields.io/github/followers/m-azyoksul?style=social)](https://github.com/m-azyoksul/)
---
<img align="right" src="https://user-images.githubusercontent.com/32205084/125903612-92e0d0ac-eaf1-4714-850d-90747b94cee5.gif">

### Demo
![stack](https://user-images.githubusercontent.com/32205084/125905278-4c0c7f21-a1df-42a9-aaff-c2b901267339.gif)


### What is `bottom_nav_layout`?
It is a quick flutter app layout for building an app with a bottom nav bar. You can get an app with fluent behavior running in 15 lines of code.

### Why `bottom_nav_layout`?
 - Eliminates all boilerplate code for bottom nav bar coordination.
 - Offers additional common features.
   - Page state preservation
   - Lazy page loading
   - Page transition animations
   - In-page navigation
   - Back button navigation for Android
 - Works with any bottom bar you want. Use the material or cupertino bottom bar, [grab one from pub.dev](https://pub.dev/packages?q=bottom+navigation+bar) or use your own.
 - You can customize or turn of any feature.

# Content
 - [Usage](#usage)
 - [Page State Preservation](#page-state-preservation)
 - [Lazy Page Loading](#lazy-page-loading)
 - [Page Back Stack](#page-back-stack)
 - [Page Transition Animation](#page-transition-animation)
 - [In-Page Navigation](#in-page-navigation)
 - [Different Bottom Bars](#different-bottom-bars)
 - [Improvements](#improvements)
 - [Community](#community)

# Usage
## Installation
Add the following to your `pubspec.yaml` file.
```yaml
dependencies:
  bottom_nav_layout: ^3.0.9
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

[SliderPage code](https://github.com/m-azyoksul/bottom_nav_layout/blob/main/example/lib/pages/slider_page.dart)

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
| `pageTransitionData` | Animation configuration for page transitions. | null |

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
 - Has a launch animation.
 - Runs a heavy process that is not needed until the page is opened.
 ```dart
 lazyLoadPages: true, // Default is false
 ```

# Page Back Stack
| Documentation | Example |
| :--- | :--- |
| [documentation](https://github.com/m-azyoksul/bottom_nav_layout/tree/main/doc/PageBackStack) | [example](https://github.com/m-azyoksul/bottom_nav_layout/blob/main/example/lib/examples/page_back_stack_example.dart) |

The layout remembers the order of pages navigated and when back button is pressed, navigates back to the previously navigated page.

```dart
// Default is ReorderToFrontPageStack for Android and NoPageStack for iOS.
pageStack: ReorderToFrontPageStack(initialPage: 0),
```

There are many useful page back stack behaviors implemented such as reorder-to-front and replace-except-first. You can also implement your own.

You also specify the `initialPage` inside `PageStack`.

To change the current page programmatically, you can use

```dart
// Navigate to a page. 
myPageStack.push(2);

// Navigate back to the previous page on the stack.
myPageStack.pop();

// PageStacks inherit ListQueue.
var top = myPageStack.peek();
var length = myPageStack.length;
```

# Page Transition Animation
| Documentation | Example |
| :--- | :--- |
| - | [example](https://github.com/m-azyoksul/bottom_nav_layout/blob/main/example/lib/examples/page_transition_example.dart) |

You can set an transition animation between pages. Create your own `AnimationBuilder` or use one of the built in ones.

These animation work with both bottom navbar and Android back button.
```dart
// Default is null.
pageTransitionData: PageTransitionData(
  builder: PrebuiltAnimationBuilderBuilders.zoomInAndFadeOut,
  duration: 150,
  direction: AnimationDirection.inAndOut,
),
```

# In-Page Navigation
| Documentation | Example |
| :--- | :--- |
| [documentation](https://github.com/m-azyoksul/bottom_nav_layout/tree/main/doc/InPageNavigation) | [example](https://github.com/m-azyoksul/bottom_nav_layout/blob/main/example/lib/examples/navigation_example.dart) |

The layout maintains a [flat navigation pattern](https://developer.apple.com/design/human-interface-guidelines/ios/app-architecture/navigation/).

<p align="center">
  <img src="https://user-images.githubusercontent.com/32205084/125260520-1024f380-e309-11eb-8c2d-4b10fc3dbc41.png">
 <br/>
  <i>Figure: Flat Navigation</i>
</p>

Benefits
 1. [`Navigator`](https://api.flutter.dev/flutter/widgets/Navigator-class.html) per page is trivial to set up.
 2. You only need to push pages you need. Pops are handled by the layout.
 3. Android back button navigates both in-page and among pages.
 4. Bottom bar pops all in-page stack when the current bar item is reselected.
 5. If you put an app bar to your page, it will show the up button correctly.

To do this, the page should have a `Navigator` widget that use the passed in `GlobalKey` as its key.

```dart
pages: [
  (navKey) => Navigator(
        key: navKey,
        initialRoute: "/",
        onGenerateRoute: (routeSettings) => MaterialPageRoute(
          builder: (context) {
            if (routeSettings.name == "/")
              return OverviewPage();
            else if (routeSettings.name == "/details")
              return DetailsPage();
            else
              return Center(child: Text("Unknown route."));
          },
        ),
      ),
  (_) => SliderPage(),
  (_) => SliderPage(),
],
```

# Different Bottom Bars
| Documentation | Example |
| :--- | :--- |
| [documentation](https://github.com/m-azyoksul/bottom_nav_layout/tree/main/doc/DifferentBottomBars) | [example](https://github.com/m-azyoksul/bottom_nav_layout/blob/main/example/lib/examples/different_bottom_bars_example.dart) |

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
 - Tell me if you want to see a feature your app has/needs in this package. I will do my best to integrate it.
 - I am also considering to make a drawer_nav_layout package. If you are interested, let me know!

# Community
Any feedback is appreciated. 🚀🚀

I love talking about code. Find me on discord at ViraL#2868

If you like this work, please consider 👍 the package and ⭐ the repo. It is appreciated.

If you have queries, feel free to create an [issue](https://github.com/m-azyoksul/bottom_nav_layout/issues).

If you would like to contribute, feel free to create a [PR](https://github.com/m-azyoksul/bottom_nav_layout/pulls).
