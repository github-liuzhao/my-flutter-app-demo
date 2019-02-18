import 'package:flutter/material.dart';

class ProductLocation extends StatelessWidget {
  final String location;
  ProductLocation(this.location);
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(4.0)),
      child: Padding(child: Text(location), padding: EdgeInsets.all(2.0),)
    );
  }
}