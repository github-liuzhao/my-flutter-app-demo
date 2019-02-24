import 'package:flutter/material.dart';

class Product {
  final String title;
  final String desc;
  final double price;
  final String image;
  final bool isMyFavorite;

  Product(
      {@required this.title,
      @required this.desc,
      @required this.price,
      @required this.image,
      this.isMyFavorite=false});
}
