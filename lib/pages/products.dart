import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../scope-model/main.dart';
import '../widget/product/products.dart';

class ProductsPage extends StatefulWidget {
  final MainModel model;
  ProductsPage(this.model){
    print('[Products Page] contructor');
  }
  @override
  State<StatefulWidget> createState() {
    return _ProductsPageState();
  }
}

class _ProductsPageState extends State<ProductsPage> {
  
  @override
  void initState() {
    widget.model.fetchProduct();
    super.initState();
  }

  Widget _buildProductsList(MainModel model){
    Widget content = Center(child: Text('No Products Found!'),);
    if(model.displayedProductsList.length > 0 && !model.isLoading){
      content = Products();
    } else if(model.isLoading){
      content = Center(child: CircularProgressIndicator(),);
    }
    // 下拉刷新
    return RefreshIndicator(child: content, onRefresh: (){
      model.fetchProduct();
    },);
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant(builder: (BuildContext context, Widget child, MainModel model){
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
            title: Text('login'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/login');
            },
          )
        ],),),
        appBar: AppBar(
          title: Text('Products'),
          actions: <Widget>[
              IconButton(
                icon: model.showFavoriteListStatus ? Icon(Icons.favorite) :Icon(Icons.favorite_border), 
                onPressed: (){
                  model.toggleFavoritListStatus();
                },
              )
            ],
        ),
        body: _buildProductsList(model)
      );
    },);
  }
}
