/////////////////////////////////////
///////// bottom_nav_layout /////////
/////////////////////////////////////
//                                 //
// Author: Mustafa Azyoksul        //
// Email: m.azyoksul@gmail.com     //
//                                 //
// github: m-azyoksul              //
// linked-in: mustafa-azyoksul     //
//                                 //
/////////////////////////////////////
import 'package:bottom_nav_layout/src/page_stack.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'nav_bar_delegate.dart';

/// Type definition for the page builder
typedef PageBuilder = Widget Function(GlobalKey<NavigatorState>);

/// [BottomNavLayout] is a quick and powerful layout tool.
/// You can create an app with fluent bottom bar behavior in less than 15 lines.
/// It coordinates all behavior regarding bottom nav bar and app's top level destinations.
///
/// [BottomNavLayout] layout consists of a [Scaffold].
/// which shows one of the [pages] inside [Scaffold.body] and has a bottom navbar as [Scaffold.bottomNavigationBar].
/// Bottom navbar controls which one of the [pages] is currently visible.
class BottomNavLayout extends StatefulWidget {
  BottomNavLayout({
    Key? key,
    required this.pages,
    this.savePageState = false,
    this.lazyLoadPages = false,
    this.pageStack,
    this.bottomBarWrapper,
    this.extendBody = false,
    this.resizeToAvoidBottomInset = true,
    required this.navBarDelegate,
  })  : assert(pages.length >= 1, "At least 1 page is required"),
        assert(pages.length == navBarDelegate.itemLength(), "Pass as many bottom navbar items as pages"),
        assert(pageStack == null || pages.length > pageStack.peek() && pageStack.peek() >= 0, "initialPageIndex cannot exceed the page number or be negative"),
        super(key: key) {
    // Create keys
    keys = pages.map((e) => GlobalKey<NavigatorState>()).toList();
  }

  /// TODO: Add docs
  final List<PageBuilder> pages;

  /// If false, the pages are reinitialized every time they are navigated to. (Material Design behavior)
  /// If true, the pages are initialized once and hidden/shown on navigation. (Cupertino behavior)
  final bool savePageState;

  /// If false, pages are created on layout creation.
  /// If true, pages are created when they are navigated for the first time.
  final bool lazyLoadPages;

  /// Initial page stack that user passed in.
  final PageStack? pageStack;

  /// A function that returns a styling widget to wrap bottom nav bar with.
  final Widget Function(Widget)? bottomBarWrapper;

  /// Similar to [Scaffold.extendBody].
  final bool extendBody;

  /// Similar to [Scaffold.resizeToAvoidBottomInset].
  final bool resizeToAvoidBottomInset;

  /// Property delegated to [BottomNavigationBar]
  final NavBarDelegate navBarDelegate;

  /// Navigation keys used for in-page navigation.
  late List<GlobalKey<NavigatorState>> keys;

  @override
  State<StatefulWidget> createState() => _BottomNavLayoutState();
}

class _BottomNavLayoutState extends State<BottomNavLayout> {
  /// [BottomNavLayout]'s page backstack. The main focus of this package.
  ///
  /// It saves pages on the backstack by their indexes. The [pageStack.peek] always contains the current page's index.
  ///
  /// Users can pass a [PageStack] instance or not. If they do not, the default one will be a [ReorderToFrontPageStack].
  /// There are different versions of stack pattern readily implemented. Users can also implement their own.
  late final PageStack pageStack;

  /// The main content of the layout.
  /// Respective widget in this list is shown above the bottom navbar.
  ///
  /// If pages are directly passed is, all pages will be present in this list at all times.
  /// If pageBuilders are passed in, the corresponding entry in the list will contain null until that page is navigated for the first time.
  late List<Widget?> pages = List.empty(growable: true);

  /// Initialize [pageStack] and [pages]
  @override
  void initState() {
    // Set the pageStack. If not passed in, initialize with default.
    pageStack = widget.pageStack ?? ReorderToFrontPageStack(initialPage: 0);

    if (!widget.lazyLoadPages)
      widget.pages.asMap().entries.forEach((element) {
        pages.add(element.value.call(widget.keys[element.key]));
      });
    //pages = widget.pages.asMap().entries.map((entry) => entry.value.call(keys[entry.key])).toList();
    else
      widget.pages.forEach((element) {
        pages.add(null);
      });
    //pages = widget.pages.asMap().entries.map((entry) => null).toList();

    super.initState();
  }

  /// If the selected page is the current page, pops the page until it reaches it's root route.
  /// If the selected page is not the current page, navigates to that page.
  void onPageSelected(int index) {
    // If the current item is selected
    if (index == pageStack.peek()) {
      // Pop until the base route
      widget.keys[index].currentState?.popUntil((route) => route.isFirst);
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
    final consumedByPage = await widget.keys[pageStack.peek()].currentState?.maybePop() ?? false;

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
    var currentIndex = pageStack.peek();

    // If the current page hasn't been initialized.
    if (pages[currentIndex] == null) {
      // Lazy load the page.
      pages[currentIndex] = widget.pages[currentIndex].call(widget.keys[currentIndex]);
    }

    // Create the bottom bar
    var bottomBar = widget.navBarDelegate.createBar(currentIndex, onPageSelected);

    // Return the view
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        extendBody: widget.extendBody,
        resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
        // Depending on if the user wants to save the page states
        body: !widget.savePageState
            // Do not save page states
            ? pages[currentIndex]
            : IndexedStack(
                index: currentIndex,
                // If the page is not initialized, "not show" an invisible widget instead.
                children: pages.map((page) => page ?? SizedBox.shrink()).toList(),
              ),
        bottomNavigationBar: widget.bottomBarWrapper?.call(bottomBar) ?? bottomBar,
      ),
    );
  }
}
