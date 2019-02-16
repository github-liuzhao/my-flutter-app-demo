import 'package:flutter/material.dart';
import './product_create.dart';
import './product_list.dart';

class ProductsAdminPage extends StatelessWidget {
  
  final Function addProduct;
  ProductsAdminPage(this.addProduct);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      // tab bar controller which wraps entire page
      // Creates a default tab controller for the given [child] widget.
      length: 2,
      child: Scaffold(
        drawer: Drawer(
          child: Column(
            children: <Widget>[
              AppBar(
                automaticallyImplyLeading: false,
                title: Text('menu bar'),
              ),
              ListTile(
                title: Text('products'),
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/products');
                  // Navigator.pushNamed(context, '/');
                },
              )
            ],
          ),
        ),
        appBar: AppBar(
          title: Text('products admin'),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.create),
                text: 'create product',
              ),
              Tab(
                icon: Icon(Icons.list),
                text: 'my product',
              ),
            ],
          ),
        ),
        body: TabBarView(children: <Widget>[
          // Creates a page view with one child per tab.
          ProductCreate(addProduct),
          ProductList(),
        ],),
      ),
    );
  }
}
