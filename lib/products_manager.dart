import 'package:flutter/material.dart';
import './products.dart';
import './products_control.dart';

class ProductsManager extends StatefulWidget {
  final String firstProduct;
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
  final List<String> _products = [];

  @override
  void initState() {
    print('[ProductsManager Widget] initState');
    if(widget.firstProduct != null){
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

  void _addProduct(String product) {
    setState(() {
      _products.add(product); // setState触发调用build
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
          child: Products(_products),
        ) // statelesswidget传递数据
      ],
    );
  }
}
