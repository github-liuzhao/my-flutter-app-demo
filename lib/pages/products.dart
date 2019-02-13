import 'package:flutter/material.dart';
import '../products_manager.dart';
import './products_admin.dart';

class ProductsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Scaffold creates a new 'page' in you app
      drawer: Drawer(child: Column(children: <Widget>[
        AppBar(
          automaticallyImplyLeading: false,
          title: Text('menu bar'),
        ),
        ListTile(
          title: Text('products manager'),
          onTap: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => ProductsAdminPage()));
          },
        )
      ],),),
      appBar: AppBar(
        title: Text('products'),
      ),
      body: ProductsManager() // 传递初始数据给statefulwidget
    );
  }
}
