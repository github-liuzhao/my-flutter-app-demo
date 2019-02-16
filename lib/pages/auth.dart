import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AuthState();
  }
}
class _AuthState extends State<AuthPage> {
  String _email;
  String _password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // Scaffold creates a new 'page' in you app
        appBar: AppBar(
          title: Text('login page'),
        ),
        body: Container(
          margin: EdgeInsets.all(10.0),
          child: Column(children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'email'),
              keyboardType: TextInputType.emailAddress,
              onChanged: (String value){
                setState(() {
                  _email = value;
                });
              },
            ),
            TextField(
              decoration: InputDecoration(labelText: 'password'),
              obscureText: true,
              onChanged: (String value) {
                setState((){
                  _password = value;
                });
              },
            ),
            RaisedButton(
              child: Text('login'),
              onPressed: () {
                print(_email);
                print(_password);
                Navigator.pushReplacementNamed(context, '/products');
              },
            ),
          ],)
        )
    );
  }
}
