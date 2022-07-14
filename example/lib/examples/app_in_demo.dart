import 'dart:async';
import 'dart:ffi';

import 'package:bottom_nav_layout/bottom_nav_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'navigation_example.dart';

/// This doesn't introduce something new.
/// This is the code used in the gif demo at the top of README
class AppInDemo extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BottomNavLayout(
      onWillPopWithOnePageOnStack: ()=>_onWillPopWithOnePageOnStack(context),
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
      pageTransitionData: PageTransitionData(
        builder: PrebuiltAnimationBuilderBuilders.zoomInAndFadeOut,
        duration: 150,
        direction: AnimationDirection.inAndOut,
      ),
    );
  }

  Future<bool> _onWillPopWithOnePageOnStack(BuildContext context) async{
    final response = await showAlertDialog(context);
    return (response) ?? false;
  }

  Future<bool?> showAlertDialog(BuildContext context) async{

    // set up the button
    Widget cancelButton = TextButton(
      child: Text("CANCEL"),
      onPressed: () {
        Navigator.pop(context, false);
      },
    );

    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context, true);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("ALert!"),
      content: Text("Sure to close app?"),
      actions: [
        cancelButton,
        okButton,
      ],
    );

    // show the dialog
    Future<bool?> response = showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );

    return response;

    //return response;
  }

}
