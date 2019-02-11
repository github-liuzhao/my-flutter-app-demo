import 'package:flutter/material.dart';

class Products extends StatelessWidget {
  final List<String> products;
  Products(this.products) {
    print('[Products Widget] constructor');
  }
  @override
  Widget build(BuildContext context) {
    print('[Products Widget] build');
    return Column(
      children: products
        .map((element) => Card(
          child: Column(
            children: <Widget>[
              // Image.asset('assets/01.jpg'),
              Container(
                margin: EdgeInsets.all(10.0),
                child: Text(element),
              )
            ],
          ),
        ))
        .toList(),
      );
  }
}