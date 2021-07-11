import 'package:bottom_nav_layout/src/page_stack.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';

/// [BottomNavLayout] is a quick and powerful layout tool.
/// You can create an app with fluent bottom bar behavior in less than 15 lines.
/// It coordinates all behavior regarding bottom nav bar and app's top level destinations.
///
/// [BottomNavLayout] layout consists of a [Scaffold].
/// which has one of the [pages] as [Scaffold.body] and a [BottomNavigationBar] as [Scaffold.bottomNavigationBar].
/// [BottomNavigationBar] controls which one of the [pages] is currently visible.
class WaterDropNavLayout extends StatefulWidget {
  WaterDropNavLayout({
    Key? key,

    // Nav layout properties
    this.pages,
    this.pageBuilders,
    this.savePageState = true,
    this.pageStack,
    this.keys,
    this.bottomBarStyler,
    this.extendBody = false,

    // Delegated properties
    required this.barItems,
    this.onButtonPressed,
    this.backgroundColor = Colors.white,
    this.waterDropColor = const Color(0xFF5B75F0),
    this.iconSize = 30,
    this.inactiveIconColor,
  })  : assert(pages != null && pageBuilders == null || pageBuilders != null && pages == null, "Either pass pages or pageBuilders"),
        assert((pages?.length ?? pageBuilders!.length) >= 2, "At least 2 pages are required"),
        assert(keys == null || (pages?.length ?? pageBuilders!.length) == keys.length, "Either do not pass keys or pass as many as pages"),
        assert((pages?.length ?? pageBuilders!.length) == barItems.length, "Pass as many bottomNavBarItems as pages"),
        assert(pageStack == null || (pages?.length ?? pageBuilders!.length) > pageStack.peek() && pageStack.peek() >= 0, "initialPageIndex cannot exceed the max page index or be negative"),
        super(key: key);

  /// The main content of the layout.
  /// Directly passed to the [_BottomNavLayoutState.pages]
  final List<Widget>? pages;

  /// Simple functions that return the respective items on [pages].
  /// When [pageBuilders] is passed, they are used to lazily initialize the pages, when the user first navigates to the respective page.
  /// Either pass [pages] or [pageBuilders], do not pass both.
  final List<Widget Function()>? pageBuilders;

  /// Whether the page states are saved or not.
  final bool savePageState;

  /// Initial page stack that user passed in.
  final PageStack? pageStack;

  /// The navigation keys of the [pages] in the layout.
  ///
  /// These keys are optional. If not used, bottom navigation backstack still functions normally.
  ///
  /// To manage all back button presses from this widget, keys of type [GlobalKey<NavigatorState>] should be used in the [pages] for navigation.
  /// These keys should be created outside the pages and the same key instances should be passed into both pages themselves and to this widget at the same time.
  ///
  /// If present, these keys are used to navigate back.
  /// The back press events will be passed to the current page's key to be consumed first.
  /// The onTap events on the current BottomNavBarItem will cause the key to pop until the root route is reached on that page.
  ///
  /// Number and order of [keys] should be the same as the order of [pages] they are passed into.
  final List<GlobalKey<NavigatorState>?>? keys;

  /// A function that returns a styling widget to wrap bottom nav bar with.
  final Widget Function(Widget)? bottomBarStyler;

  /// Weather the body will extend behind the bottom bar or not.
  final bool extendBody;

  /// Property delegated to [WaterDropNavBar]
  final List<BarItem> barItems;

  /// Property delegated to [WaterDropNavBar]
  final ValueChanged<int>? onButtonPressed;

  /// Property delegated to [WaterDropNavBar]
  final Color backgroundColor;

  /// Property delegated to [WaterDropNavBar]
  final Color waterDropColor;

  /// Property delegated to [WaterDropNavBar]
  final double iconSize;

  /// Property delegated to [WaterDropNavBar]
  final Color? inactiveIconColor;

  @override
  State<StatefulWidget> createState() => _WaterDropNavLayoutState();
}

class _WaterDropNavLayoutState extends State<WaterDropNavLayout> {
  /// [BottomNavLayout]'s page backstack. The main focus of this package.
  ///
  /// It saves pages on the backstack by their indexes. The [pageStack.peek] always contains the current page's index.
  ///
  /// Users can pass a [PageStack] instance or not. If they do not, the default one will be a [ReorderToFrontPageStack].
  /// There are different versions of stack pattern readily implemented. Users can also implement their own.
  late final PageStack pageStack;

  /// The main content of the layout.
  /// Respective widget in this list is shown above the [BottomNavigationBar].
  ///
  /// If pages are directly passed is, all pages will be present in this list at all times.
  /// If pageBuilders are passed in, the corresponding entry in the list will contain null until that page is navigated for the first time.
  final List<Widget?> pages = List.empty(growable: true);

  /// Initialize [pageStack] and [pages]
  @override
  void initState() {
    // Set the pageStack. If not passed in, initialize with default.
    pageStack = widget.pageStack ?? ReorderToFrontPageStack(initialPage: 0);

    // If pages are passed in, just set them.
    if (widget.pages != null) {
      // Add all pages
      widget.pages!.forEach((page) => pages.add(page));
    }
    // If not, they will be lazily initialized on runtime.
    else {
      // Add a null for each page
      widget.pageBuilders!.forEach((_) => pages.add(null));
    }

    super.initState();
  }

  /// If the selected page is the current page, pops the page until it reaches it's root route.
  /// If the selected page is not the current page, navigates to that page.
  void onPageSelected(int index) {
    // If the current item is selected
    if (index == pageStack.peek()) {
      // Pop until the base route
      widget.keys?[index]?.currentState?.popUntil((route) => route.isFirst);
    }
    // If something else than current item is selected
    else {
      // Navigate to page
      pageStack.push(index);

      // Set state to change the page
      setState(() {});
    }
  }

  /// Sends the pop event to the current page first. If it doesn't consume it, then tries to pop the pageStack.
  /// If there are more than one items in the pageStack, pops back to the previous page on the stack.
  /// If there is a single page in the stack, bubbles up the pop event. Exits the app if no other back button handler is configured in the app.
  Future<bool> onWillPop() async {
    // Send pop event to the inner page
    final consumedByPage = await widget.keys?[pageStack.peek()]?.currentState?.maybePop() ?? false;

    // If the back event is consumed by the inner page
    if (consumedByPage) {
      // Consume pop event
      return false;
    }

    // Pop the top element from bottom navigation stack
    pageStack.pop();

    // If the stack is not empty
    if (pageStack.isNotEmpty) {
      // Set state to change the page
      setState(() {});

      // Consume pop event
      return false;
    }

    // Bubble up the pop event.
    return true;
  }

  /// If the current page is null, then it needs to be built from the [widget.pageBuilders] before being shown.
  @override
  Widget build(BuildContext context) {
    // If the current page hasn't been initialized.
    if (pages[pageStack.peek()] == null) {
      // Create the page from the builder and put it into page list.
      pages[pageStack.peek()] = widget.pageBuilders![pageStack.peek()]();
    }

    // Create the bottom nav bar
    var bottomBar = WaterDropNavBar(
      selectedIndex: pageStack.peek(),

      // onTap calls both the layout's own onTap action and the user's passed in onTap action.
      onButtonPressed: (index) {
        // Layout functionality
        onPageSelected(index);

        // Passed in onTap call
        widget.onButtonPressed?.call(index);
      },

      // Delegated properties
      key: widget.key,
      barItems: widget.barItems,
      backgroundColor: widget.backgroundColor,
      waterDropColor: widget.waterDropColor,
      iconSize: widget.iconSize,
      inactiveIconColor: widget.inactiveIconColor,
    );

    // Return the view
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        extendBody: widget.extendBody,
        // Depending on if the user wants to save the page states
        body: !widget.savePageState
            // Do not save page states
            ? pages[pageStack.peek()]
            // Save page states using a stack/offstage structure.
            // Stack view contains one Offstage widget per page.
            // Offstages are hidden except for the currently selected page.
            : Stack(
                children: pages.asMap().entries.map((indexPageMap) {
                  return Offstage(
                    offstage: indexPageMap.key != pageStack.peek(),
                    // If the page is not initialized, "not show" an invisible widget instead.
                    child: indexPageMap.value ?? SizedBox.shrink(),
                  );
                }).toList(),
              ),
        bottomNavigationBar: widget.bottomBarStyler?.call(bottomBar) ?? bottomBar,
      ),
    );
  }
}
