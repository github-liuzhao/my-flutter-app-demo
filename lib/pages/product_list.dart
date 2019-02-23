import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import './product_edit.dart';
import '../model/product.dart';
import '../scope-model/products.dart';

class ProductList extends StatelessWidget {
  ProductList() {
    print('ProductList widget constructor');
  }

  Widget _buildItemBuilder(BuildContext context, int index, List<Product> products, Function delProductItem){
    return Dismissible(
      key: Key(products[index].title),
      onDismissed: (DismissDirection direction){
        if(direction == DismissDirection.endToStart){
          delProductItem(index);
        }
      },
      background: Container(
        color: Colors.red,
      ),
      child: Column(
        children: <Widget>[
          ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(products[index].image),
            ),
            title: Text(products[index].title),
            subtitle: Text('\$${products[index].price}'),
            trailing: IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                // ??
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (BuildContext context) {
                  return ProductEdit(index);
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
    return ScopedModelDescendant(builder: (BuildContext context, Widget child, ProductsModel model){
      return ListView.builder(
        itemBuilder: (context, index) => _buildItemBuilder(context, index, model.products, model.delProductItem),
        itemCount: model.products.length
      );
    },);
  }
}
