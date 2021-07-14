import 'package:flutter/material.dart';

class Nav{
  static pushMaterialRoute(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => page));
  }
}