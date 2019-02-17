import 'package:flutter/material.dart';
import './product_card.dart';

class Products extends StatelessWidget {
  final List<Map<String, dynamic>> products;
  final Function delProductItem;

  Products({this.products, this.delProductItem}) {
    print('[Products Widget] constructor');
  }

  Widget _buildProductList() {
    Widget productList = Center(
      child: Text('product list is empty'),
    );
    if (products.length > 0) {
      productList = ListView.builder(
        // Creates a scrollable, linear array of widgets that are created on demand.
        itemBuilder: (BuildContext context, int index){
          return ProductCard(products[index], index);
        },
        itemCount: products.length,
      );
    }
    return productList;
  }

  @override
  Widget build(BuildContext context) {
    print('[Products Widget] build');
    return _buildProductList();
  }
}
