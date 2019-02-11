import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
import './products_manager.dart';

void main() {
  // debugPaintSizeEnabled = true;
  // debugPaintPointersEnabled = true;
  // debugPaintBaselinesEnabled = true;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final String firstProduct = 'first default product';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // debugShowMaterialGrid: true,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.green,
        accentColor: Colors.greenAccent
      ),
      home: Scaffold(
          appBar: AppBar(
            title: Text('EaseList'),
          ),
          body: ProductsManager() // 传递数据给statefulwidget
      ),
    );
  }
}
