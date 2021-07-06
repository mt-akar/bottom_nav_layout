import 'package:bottom_nav_layout/src/tab_stack.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'bottom_nav_bar_delegate.dart';

/// TODO: What is BottomNavLayout
/// TODO: Why does BottomNavLayout exist, what is it's purpose
/// TODO: What does BottomNavLayout do
///
/// [BottomNavLayout] layout consists of a [Scaffold].
/// which has one of the [pages] as [Scaffold.body] and a [BottomNavigationBar] as [Scaffold.bottomNavigationBar].
/// [BottomNavigationBar] controls which one of the [pages] is currently visible.
///
/// While navigating around with [BottomNavigationBar], [pages] do not get destroyed/rebuilt, only get hidden/visible.
/// This way, the pages saves all their state.
class BottomNavLayout extends StatefulWidget {
  BottomNavLayout({
    this.keys,
    this.pages,
    this.pageBuilders,
    this.tabStack,
    required this.bottomNavBarDelegate,
  })  : assert(pages != null && pageBuilders == null || pageBuilders != null && pages == null, "Either pass pages or pageBuilders"),
        assert((pages?.length ?? pageBuilders!.length) >= 2, "At least 2 Pages are required"),
        assert(keys == null || (pages?.length ?? pageBuilders!.length) == keys.length, "Either do not pass keys or pass as many as Pages"),
        assert((pages?.length ?? pageBuilders!.length) == bottomNavBarDelegate.items.length, "Pages and BottomNavBarItems should be equal in number"),
        assert(tabStack == null || (pages?.length ?? pageBuilders!.length) > tabStack.peek(), "Initial tab index cannot exceed the maximum page index");

  /// The navigation keys of the [pages] in the layout.
  ///
  /// These keys are optional. If not used, bottom navigation backstack still functions normally.
  ///
  /// To manage all back button presses in this widget, keys of type [GlobalKey<NavigatorState>] for navigation should be used in the [pages].
  /// These keys should be created outside the pages and the same key instances should be passed into both pages and to this widget at the same time.
  ///
  /// Once present, these keys are used to navigate back.
  /// The back press events will be passed to the current page's key to be consumed first.
  /// The onTap events on the current BottomNavBarItem will cause the key to pop until the root route is reached on that page.
  ///
  /// Number and order of [keys] should be the same as the order of [pages] they are passed into.
  final List<GlobalKey<NavigatorState>?>? keys;

  /// The main content of [BottomNavLayout] layout.
  final List<Widget>? pages;

  /// These page builders are simple functions that return the respective pages.
  /// When [pageBuilders] is passed instead of [pages], they are used to lazily initialize the pages, when the user first navigates to that tab.
  final List<StatelessWidget Function()>? pageBuilders;

  /// Initial tab stack that user passed in.
  final TabStack? tabStack;

  /// Delegate for all the of the [BottomNavigationBar] properties, except [BottomNavigationBar.currentIndex].
  ///
  /// [BottomNavigationBar.currentIndex] functionality is captured in [_BottomNavLayoutState.tabStack].
  /// Initial tab index could still be passed in [TabStack]'s constructor.
  final BottomNavBarDelegate bottomNavBarDelegate;

  @override
  State<StatefulWidget> createState() => _BottomNavLayoutState();
}

class _BottomNavLayoutState extends State<BottomNavLayout> {
  /// [BottomNavLayout]'s tab backstack. The main focus of this package.
  ///
  /// It saves tabs on the backstack by their indexes. The [tabStack.peek] always contains the current tab's index.
  ///
  /// Users can pass a [TabStack] instance or not. If they do not, the default one will be a [ReorderToFrontTabStack].
  /// There are different versions of stack pattern readily implemented. Users can also implement their own.
  late final TabStack tabStack;

  late final List<Widget?> pages;

  @override
  void initState() {
    // If the tabStack is not passed in, initialize it with default.
    tabStack = widget.tabStack ?? ReorderToFrontTabStack(initialTab: 0);

    // Initialize the pages. If pages are passed in, just set it. If not, they will be lazily initialized on runtime.
    if (widget.pages != null) {
      pages = widget.pages!;
    } else {
      pages = List.empty();
      widget.pageBuilders!.forEach((element) => pages.add(null));
      //pages = widget.pageBuilders!.map<Widget?>((e) => null).toList();
    }

    super.initState();
  }

  /// If the selected tab is the current tab, pops the page until it reaches it's root route.
  /// If the selected tab is not the current tab, navigates to that tab.
  void onTabSelected(int index) {
    // If the current item is selected
    if (index == tabStack.peek()) {
      // Pop until the base route
      widget.keys?[index]?.currentState?.popUntil((route) => route.isFirst);
    }
    // If something else than current item is selected
    else {
      // Navigate to tab
      tabStack.push(index);

      // Set state to change the page
      setState(() {});
    }
  }

  /// Sends the pop event to the current page first. If it doesn't consume it, then tries to pop the tabStack.
  /// If there are more than one items in the tabStack, pops back to the previous page on the stack.
  /// If there is a single tab in the stack, bubbles up the pop event. Exits the app if no other back button handler is added.
  Future<bool> onWillPop() async {
    // Send pop event to the inner page
    final consumedByPage = await widget.keys?[tabStack.peek()]?.currentState?.maybePop() ?? false;

    // If the back event is consumed by the inner page
    if (consumedByPage) {
      // Consume pop event
      return false;
    }

    // Pop the top element from bottom navigation stack
    tabStack.pop();

    // If the stack is not empty
    if (tabStack.isNotEmpty) {
      // Set state to change the page
      setState(() {});

      // Consume pop event
      return false;
    }

    // Bubble up the pop event.
    return true;
  }

  /// If the current page is null, then it needs to be built from the [widget.pageBuilders]
  @override
  Widget build(BuildContext context) {
    // If the current page is null, then build it.
    if (pages[tabStack.peek()] == null) {
      pages[tabStack.peek()] = widget.pageBuilders![tabStack.peek()]();
    }

    // Return the view
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        // All the pages are initialized and running regardless of which view is currently visible.
        // This stack view contains one Offstage widget per page.
        // Offstages are hidden unless the corresponding tab is currently selected.
        //
        // If body was defined as following:
        // body: widget.pages[widget.tabStack.peek()],
        // the page states would not have been saved and restored.
        body: Stack(
          children: pages.asMap().entries.where((indexPageMap) => indexPageMap.value != null).map((indexPageMap) {
            return Offstage(
              offstage: indexPageMap.key != tabStack.peek(),
              child: indexPageMap.value,
            );
          }).toList(),
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            // Additional functionality
            onTabSelected(index);

            // Passed in onTap method
            widget.bottomNavBarDelegate.onTap?.call(index);
          },
          currentIndex: tabStack.peek(),

          // Delegated properties
          key: widget.bottomNavBarDelegate.key,
          items: widget.bottomNavBarDelegate.items,
          elevation: widget.bottomNavBarDelegate.elevation,
          type: widget.bottomNavBarDelegate.type,
          fixedColor: widget.bottomNavBarDelegate.fixedColor,
          backgroundColor: widget.bottomNavBarDelegate.backgroundColor,
          iconSize: widget.bottomNavBarDelegate.iconSize,
          selectedItemColor: widget.bottomNavBarDelegate.selectedItemColor,
          unselectedItemColor: widget.bottomNavBarDelegate.unselectedItemColor,
          selectedIconTheme: widget.bottomNavBarDelegate.selectedIconTheme,
          unselectedIconTheme: widget.bottomNavBarDelegate.unselectedIconTheme,
          selectedFontSize: widget.bottomNavBarDelegate.selectedFontSize,
          unselectedFontSize: widget.bottomNavBarDelegate.unselectedFontSize,
          selectedLabelStyle: widget.bottomNavBarDelegate.selectedLabelStyle,
          unselectedLabelStyle: widget.bottomNavBarDelegate.unselectedLabelStyle,
          showSelectedLabels: widget.bottomNavBarDelegate.showSelectedLabels,
          showUnselectedLabels: widget.bottomNavBarDelegate.showUnselectedLabels,
          mouseCursor: widget.bottomNavBarDelegate.mouseCursor,
        ),
      ),
    );
  }
}
