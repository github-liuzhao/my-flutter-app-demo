import 'package:flutter/material.dart';
import './products.dart';

class ProductsManager extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProductManagerState();
  }
}

class _ProductManagerState extends State<ProductsManager> {
  List<String> _products = ['pro first'];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(10.0),
          child: RaisedButton(
            onPressed: () {
              setState(() {
                _products.add('pro added');
              });
            },
            child: Text('clike me'),
          ),
        ),
        Products(_products)
      ],
    );
  }
}
