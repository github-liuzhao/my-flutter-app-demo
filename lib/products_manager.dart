import 'package:flutter/material.dart';
import './products.dart';

class ProductsManager extends StatelessWidget {
  final List<Map<String, dynamic>> products;
  final Function addProduct;
  final Function delProductItem;

  ProductsManager({this.products, this.addProduct, this.delProductItem}) {
    print('[ProductsManager Widget] constructor');
  }

  @override
  Widget build(BuildContext context) {
    print('[ProductsManager Widget] build');
    return Column(
      children: <Widget>[
        Expanded(
          child: Products(products: products, delProductItem: delProductItem),
          // statelesswidget传递数据
          // 一个位置参数 positoin parameters，一个命名参数 named parameters
          // the expanded widget will take the remaining space after the the other widgets
        ), 
      ],
    );
  }
}
