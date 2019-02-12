import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
import './pages/auth.dart';

void main() {
  // debugPaintSizeEnabled = true;
  // debugPaintPointersEnabled = true;
  // debugPaintBaselinesEnabled = true;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // final Map<String, String> firstProduct = {};
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // MaterialApp is the wrapper for entire app
      // debugShowMaterialGrid: true,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.green,
        accentColor: Colors.greenAccent
      ),
      home: AuthPage()
    );
  }
}
