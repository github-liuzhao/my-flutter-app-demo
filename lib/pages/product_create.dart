import 'package:flutter/material.dart';

class ProductCreate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(
        child: Text('dialog'),
        onPressed: () {
          showModalBottomSheet(context: context, builder: (BuildContext context) {
            return Center(child: Text('nada'),);
          });
        },
      ),
    );
  }
}
