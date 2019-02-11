import 'package:flutter/material.dart';

class Products extends StatelessWidget {
  final List<String> products;
  Products(this.products) {
    print('[Products Widget] constructor');
  }

  Widget _buildProductItem(BuildContext context, int index) {
    return Card(
      child: Column(
        children: <Widget>[
          Image.asset('assets/01.png'),
          Text('${products[index]} - ${index + 1}'),
        ],
      ),
    );
  }

  Widget _buildProductList() {
    Widget productList = Center(child: Text('click button, add a new product'),);
    if(products.length > 0){
      productList = ListView.builder(
        itemBuilder: _buildProductItem,
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
