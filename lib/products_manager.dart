import 'package:flutter/material.dart';
import './products.dart';

class ProductsManager extends StatefulWidget {
  
  final String startMsg;
  ProductsManager(this.startMsg) {
    print('[ProductsManager Widget] constructor');
  }

  @override
  State<StatefulWidget> createState() {
    print('[ProductsManager Widget] createState');
    return _ProductManagerState();
  }
}

class _ProductManagerState extends State<ProductsManager> {
  List<String> _products = [];

  @override
  void initState() {
    print('[ProductsManager Widget] initState');
    _products.add(widget.startMsg);
    super.initState();
  }

  @override
  void didUpdateWidget(ProductsManager oldWidget) {
    print('[ProductsManager Widget] didUpdateWidget()');
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    print('[ProductsManager Widget] build');
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
