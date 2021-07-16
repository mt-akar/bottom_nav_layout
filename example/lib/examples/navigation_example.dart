import 'package:bottom_nav_layout/bottom_nav_layout.dart';
import 'package:example/pages/slider_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// In-page navigation example with bottom_nav_layout package.
class NavigationExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavLayout(
      pages: [
        (navKey) => HomePage(navKey: navKey),
        (navKey) => DashboardPage(
              navKey: navKey,
              initialPage: StackablePage(0, "Dashboard"),
            ),
        (navKey) => NavigatorWithoutRouteNames(
              navKey: navKey,
              initialPage: StackablePage(0, "Search"),
            ), // NavigatorWithoutRouteNames
      ],
      bottomNavigationBar: (currentIndex, onTap) => BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => onTap(index),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.dashboard), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
        ],
      ),
      savePageState: true,
    );
  }
}

/// [HomePage] consist of 2 destinations: [OverviewPage] and [DetailsPage].
class HomePage extends StatelessWidget {
  final GlobalKey<NavigatorState> navKey;

  const HomePage({required this.navKey});

  @override
  Widget build(BuildContext context) {
    return Navigator(
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
    );
  }
}

class OverviewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Overview Page"),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, "/details"),
              child: Text("Go to details page"),
            ),
          ],
        ),
      );
}

class DetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Details Page"),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Go back to overview"),
            ),
          ],
        ),
      );
}

/// [DashboardPage] doesn't use named routes.
/// It pushes widgets directly.
///
/// Alternatively, you can use [NavigatorWithoutRouteNames]
class DashboardPage extends StatelessWidget {
  DashboardPage({required this.navKey, required this.initialPage});

  final GlobalKey<NavigatorState> navKey;
  final Widget initialPage;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navKey,
      onGenerateRoute: (_) => MaterialPageRoute(
        builder: (_) => initialPage,
      ),
    );
  }
}

class StackablePage extends StatelessWidget {
  final int id;
  final String name;

  const StackablePage(this.id, this.name, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(name)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("${id < 5 ? "" : "You have come very far. "}Id: $id"),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => StackablePage(id + 1, name)));

                // You can also call
                // NavExtensions.push(context, StackablePage(id + 1, name));
              },
              child: Text("Go to next page"),
            ),
            if (id != 0)
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: Text("Go back"),
              ),
            SliderPage(),
          ],
        ),
      ),
    );
  }
}
