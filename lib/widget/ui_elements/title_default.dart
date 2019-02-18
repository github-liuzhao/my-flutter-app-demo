import 'package:flutter/material.dart';

class DefaultTitle extends StatelessWidget {
  final String title;
  DefaultTitle(this.title);
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontFamily: 'Oswald',
        fontSize: 20.0
      ),
    );
  }
}