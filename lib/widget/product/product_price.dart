import 'package:flutter/material.dart';

class ProductPrice extends StatelessWidget{
  final String price;
  ProductPrice(this.price);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
      decoration: BoxDecoration(color: Theme.of(context).accentColor, borderRadius: BorderRadius.circular(4.0)),
      child: Text('\$$price', style: TextStyle(color: Colors.white, fontSize: 12.0)),
    );
  }
}