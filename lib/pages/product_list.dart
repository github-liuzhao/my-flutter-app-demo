import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import './product_edit.dart';
import '../model/product.dart';
import '../scope-model/main.dart';

class ProductList extends StatefulWidget {
  final MainModel model;
  ProductList(this.model) {
    print('ProductList widget constructor');
  }
  @override
  State<StatefulWidget> createState() {
    return _ProductListState();
  }
}

class _ProductListState extends State<ProductList> {
  
  @override
  void initState(){
    widget.model.fetchProduct();
    super.initState();
  }

  Widget _buildItemBuilder(BuildContext context, int index, List<Product> products, Function delProductItem){
    return Dismissible(
      key: Key(products[index].id.toString()),
      onDismissed: (DismissDirection direction){
        if(direction == DismissDirection.endToStart){
          delProductItem(products[index].id);
        }
      },
      background: Container(
        color: Colors.red,
      ),
      child: Column(
        children: <Widget>[
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(products[index].image),
            ),
            title: Text(products[index].title),
            subtitle: Text('\$${products[index].price}'),
            trailing: IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                // ??
                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                  return ProductEdit(products[index].id, widget.model);
                }));
              },
            ),
          ),
          Divider(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant(builder: (BuildContext context, Widget child, MainModel model){
      return ListView.builder(
        itemBuilder: (context, index) => _buildItemBuilder(context, index, model.products, model.delProductItem),
        itemCount: model.products.length
      );
    },);
  }
}
