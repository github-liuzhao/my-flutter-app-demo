import 'package:flutter/material.dart';
import './product_edit.dart';
import './product_list.dart';

class ProductsAdminPage extends StatelessWidget {
  Drawer _buildDrewer(BuildContext context){
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            automaticallyImplyLeading: false,
            title: Text('menu bar'),
          ),
          ListTile(
            leading: Icon(Icons.list),
            title: Text('products'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/products');
              // Navigator.pushNamed(context, '/');
            },
          )
        ],
      ),
    );
  }

  Widget _buildTabBar(){
    return TabBar(
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      // tab bar controller which wraps entire page
      // Creates a default tab controller for the given [child] widget.
      length: 2,
      child: Scaffold(
        drawer: _buildDrewer(context),
        appBar: AppBar(
          title: Text('products admin'),
          bottom: _buildTabBar()
        ),
        body: TabBarView(children: <Widget>[
          // Creates a page view with one child per tab.
          ProductEdit(),
          ProductList(),
        ],),
      ),
    );
  }
}
