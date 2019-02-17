import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
import './pages/auth.dart';
import './pages/products.dart';
import './pages/products_admin.dart';
import './pages/product.dart';

void main() {
  // debugPaintSizeEnabled = true; // show the visual layout
  // debugPaintPointersEnabled = true;
  // debugPaintBaselinesEnabled = true;
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyApp();
  }
}

class _MyApp extends State<MyApp> {
  List<Map<String, dynamic>> _products = [];

  void _addProduct(Map<String, dynamic> product) {
    print(product);
    setState(() {
      _products.add(product); // setState会触发调用build
    });
  }

  void _delProductItem(int index) {
    setState(() {
      _products.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // MaterialApp is the wrapper for entire app
      // debugShowMaterialGrid: true,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.blue,
        accentColor: Colors.blueAccent
      ),
      routes: <String, WidgetBuilder>{
        // route registry
        '/': (BuildContext context) => AuthPage(),
        '/products': (BuildContext context) => ProductsPage(products: _products, addProduct: _addProduct, delProductItem: _delProductItem),
        '/admin': (BuildContext context) => ProductsAdminPage(_addProduct),
      },
      onGenerateRoute: (RouteSettings settings) {
        // onGenerateRoute is excuted when we navigete to a named route
        // and it only excutes if we navigate a named route which is not registered in our route registry
        // the function gets an input provied automatically by flutter which is of type route setting
        // parsing route data manually
        final List<String> pathElements = settings.name.split('/');
        if(pathElements[0] != '') {
          return null;
        }
        if(pathElements[1] == 'product') {
          final int index = int.parse(pathElements[2]);
          return MaterialPageRoute<bool>(
            builder: (BuildContext context) => ProductPage(_products[index]['title'], _products[index]['image'])
          );
        }
      },
      onUnknownRoute: (RouteSettings settings) {
        return MaterialPageRoute(builder: (BuildContext context) => ProductsPage(products: _products, addProduct: _addProduct, delProductItem: _delProductItem),);
      },
    );
  }
}
