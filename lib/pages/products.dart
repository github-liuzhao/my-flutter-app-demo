
import 'package:flutter/material.dart';
import '../products_manager.dart';

class ProductsPage extends StatelessWidget {
  final List<Map<String, dynamic>> products;
  final Function addProduct;
  final Function delProductItem;

  ProductsPage({this.products, this.addProduct, this.delProductItem}){
    print('[Products Page] contructor');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Scaffold creates a new 'page' in you app
      drawer: Drawer(child: Column(children: <Widget>[
        // Creates a material design drawer.
        AppBar(
          automaticallyImplyLeading: false,
          title: Text('menu bar'),
          
        ),
        ListTile(
          leading:Icon(Icons.edit),
          title: Text('products manager'),
          onTap: () {
            // Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => ProductsAdminPage()));
            // in this way we alwarys creating the meterial page route
            Navigator.pushReplacementNamed(context, '/admin');
          },
        ),
        ListTile(
          title: Text('unknowroute'),
          onTap: () {
            Navigator.pushReplacementNamed(context, '/sdfasf');
          },
        )
      ],),),
      appBar: AppBar(
        title: Text('Products'),
        actions: <Widget>[
            IconButton(
              icon: Icon(Icons.favorite), 
              onPressed: (){
              },
            )
          ],
      ),
      body: ProductsManager(products: products, addProduct: addProduct, delProductItem: delProductItem) // 传递初始数据给statefulwidget
    );
  }
}
