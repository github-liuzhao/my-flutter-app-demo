import 'package:flutter/material.dart';
import './products.dart';

class AuthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Scaffold creates a new 'page' in you app
      appBar: AppBar(
        title: Text('login page'),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('login'),
          onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => ProductsPage()));
          },
        )
      )
    );
  }
}