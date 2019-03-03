import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
import 'package:scoped_model/scoped_model.dart';
import './scope-model/main.dart';
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
  final MainModel model = MainModel();
  @override
  Widget build(BuildContext context) {
    return ScopedModel<MainModel>(
      model: model,
      child: MaterialApp(
        // MaterialApp is the wrapper for entire app
        // debugShowMaterialGrid: true,
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.purple,
          accentColor: Colors.purpleAccent,
          buttonColor: Colors.purpleAccent
        ),
        routes: <String, WidgetBuilder> {
          // route registry
          '/': (BuildContext context) => AuthPage(),
          '/products': (BuildContext context) => ProductsPage(model),
          '/admin': (BuildContext context) => ProductsAdminPage(model),
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
            final int id = int.parse(pathElements[2]);
            return MaterialPageRoute<bool>(
              builder: (BuildContext context) => ProductPage(id),
            );
          }
        },
        onUnknownRoute: (RouteSettings settings) {
          return MaterialPageRoute(builder: (BuildContext context) => ProductsPage(model));
        },
      )
    );
  }
}
