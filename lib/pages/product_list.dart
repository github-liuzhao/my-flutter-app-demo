import 'package:flutter/material.dart';
import './product_edit.dart';

class ProductList extends StatelessWidget {

  final Function editProduct;
  final List<Map<String, dynamic>> products;
  ProductList({this.products, this.editProduct});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index){
        return ListTile(
          leading: Image.asset(products[index]['image'], height: 50.0,),
          title: Text(products[index]['title']),
          trailing: IconButton(
            icon: Icon(Icons.edit), 
            onPressed: (){
              // ??
              Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
                return ProductEdit(product: products[index], productIndex: index, editProduct: editProduct);
              }));
            },
          ),
        );
      }, 
      itemCount: products.length
    );
  }
}