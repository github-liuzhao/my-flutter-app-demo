
import 'package:flutter/material.dart';
import '../widget/product/products.dart';

class ProductsPage extends StatelessWidget {

  ProductsPage(){
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
      body: Products()
    );
  }
}
