import 'package:flutter/material.dart';
import './products_manager.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final String firstProduct = 'first product';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.green,
        accentColor: Colors.greenAccent
      ),
      home: Scaffold(
          appBar: AppBar(
            title: Text('EaseList'),
          ),
          body: ProductsManager(firstProduct) // 传递数据给statefulwidget
      ),
    );
  }
}
