import 'package:flutter/material.dart';

class Product {
  final String id;
  final String title;
  final String desc;
  final double price;
  final String image;
  final String userEmail;
  final String userId;
  final bool isMyFavorite;

  Product(
      {
      @required this.id,
      @required this.title,
      @required this.desc,
      @required this.price,
      @required this.image,
      @required this.userEmail,
      @required this.userId,
      this.isMyFavorite=false});
}
