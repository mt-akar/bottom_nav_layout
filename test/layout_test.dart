import 'package:bottom_nav_layout/bottom_nav_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('layout test', (WidgetTester tester) async {
    bool lazyLoadPages = false;
    var welcomeText = Text("Welcome to bottom_nav_layout");
    var sliderField =
        TextField(decoration: InputDecoration(hintText: 'Slider..'));
    var searchField = TextField(decoration: InputDecoration(hintText: 'Go..'));

    // Create the widget by telling the tester to build it.
    await tester.pumpWidget(MaterialApp(
      home: BottomNavLayout(
        lazyLoadPages: lazyLoadPages,
        pages: [
          (_) => Center(child: welcomeText),
          (_) => Center(child: sliderField),
          (_) => Center(child: searchField),
        ],
        bottomNavigationBar: (currentIndex, onTap) => BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) => onTap(index), // onTap: onTap,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.linear_scale), label: 'Slider'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          ],
        ),
      ),
    ));

    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Slider'), findsOneWidget);
    expect(find.text('Search'), findsOneWidget);
    expect(find.text("Welcome to bottom_nav_layout"), findsOneWidget);
    expect(find.byWidget(welcomeText), findsOneWidget);
    if (lazyLoadPages)
      expect(find.byWidget(sliderField), findsNothing);
    else
      expect(find.byWidget(sliderField), findsOneWidget);
  });
}
