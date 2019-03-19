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
  bool _isAuthenticated = false;

  @override
  void initState() {
    model.autoAuthenticate();
    model.userSubject.listen((bool isAuthenticated){
      setState(() { 
        print('initState isAuthenticated $isAuthenticated');
        _isAuthenticated = isAuthenticated;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('app building');
    print('_isAuthenticated : $_isAuthenticated');
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
          '/': (BuildContext context) {
            print('route / status: $_isAuthenticated');
            return _isAuthenticated ? ProductsPage(model) : AuthPage();
          },
          '/admin': (BuildContext context) => _isAuthenticated ? ProductsAdminPage(model) : AuthPage(),
        },
        onGenerateRoute: (RouteSettings settings) {
          // onGenerateRoute is excuted when we navigete to a named route
          // and it only excutes if we navigate a named route which is not registered in our route registry
          // the function gets an input provied automatically by flutter which is of type route setting
          // parsing route data manually

          if(!_isAuthenticated){
            // the check at the beginning of onGenerateRoute only catches new navigation actions, 
            // not routes which were already loaded
            return MaterialPageRoute<bool>(
              builder: (BuildContext context) => AuthPage(),
            );
          }

          final List<String> pathElements = settings.name.split('/');
          if(pathElements[0] != '') {
            return null;
          }
          if(pathElements[1] == 'product') {
            final String id = pathElements[2];
            return MaterialPageRoute<bool>(
              builder: (BuildContext context) => _isAuthenticated ? ProductPage(id, model) : AuthPage(),
            );
          }
        },
        onUnknownRoute: (RouteSettings settings) {
          return MaterialPageRoute(builder: (BuildContext context) => _isAuthenticated ? ProductsPage(model) :  AuthPage());
        },
      )
    );
  }
}
