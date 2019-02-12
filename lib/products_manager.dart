import 'package:flutter/material.dart';
import './products.dart';
import './products_control.dart';

class ProductsManager extends StatefulWidget {
  final Map<String, String> firstProduct;
  ProductsManager({this.firstProduct}) {
    print('[ProductsManager Widget] constructor');
  }

  @override
  State<StatefulWidget> createState() {
    print('[ProductsManager Widget] createState');
    return _ProductManagerState();
  }
}

class _ProductManagerState extends State<ProductsManager> {
  final List<Map<String, String>> _products = [];

  @override
  void initState() {
    print('[ProductsManager Widget] initState');
    if (widget.firstProduct != null) {
      // 设置初始化数据， data can be passed from widget to State by useing the special 'widget' property
      _products.add(widget.firstProduct);
    }
    super.initState();
  }

  @override
  void didUpdateWidget(ProductsManager oldWidget) {
    print('[ProductsManager Widget] didUpdateWidget()');
    super.didUpdateWidget(oldWidget);
  }

  void _addProduct(Map<String, String> product) {
    setState(() {
      _products.add(product); // setState会触发调用build
    });
  }

  void _delProductItem(int index) {
    setState(() {
      _products.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    print('[ProductsManager Widget] build');
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(10.0),
          child: ProductsControl(_addProduct)
        ), // 方法下传
        Expanded(
          child: Products(_products, delProductItem: _delProductItem),
          // statelesswidget传递数据
          // 一个位置参数 positoin parameters，一个命名参数 named parameters
          // the expanded widget will take the remaining space after the the other widgets
        ), 
      ],
    );
  }
}
