import 'package:flutter/material.dart';
import './product_edit.dart';

class ProductList extends StatelessWidget {
  final Function editProduct;
  final Function delProductItem;
  final List<Map<String, dynamic>> products;
  ProductList({this.products, this.editProduct, this.delProductItem}) {
    print('ProductList widget constructor');
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            key: Key(products[index]['title']),
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
                    backgroundImage: AssetImage(products[index]['image']),
                  ),
                  title: Text(products[index]['title']),
                  subtitle: Text('\$${products[index]['price']}'),
                  trailing: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      // ??
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                        return ProductEdit(
                            product: products[index],
                            productIndex: index,
                            editProduct: editProduct);
                      }));
                    },
                  ),
                ),
                Divider(),
              ],
            ),
          );
        },
        itemCount: products.length);
  }
}
