import 'package:flutter/material.dart';

class ProductsControl extends StatelessWidget {

  final Function _addProduct;
  ProductsControl(this._addProduct);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: Theme.of(context).primaryColor,
      onPressed: () {
        _addProduct('product number'); // 触发父组件函数
      },
      child: Text('add product'),
    );
  }
}
