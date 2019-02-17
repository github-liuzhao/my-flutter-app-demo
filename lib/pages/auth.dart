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
  bool _acceptStatus = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // Scaffold creates a new 'page' in you app
        appBar: AppBar(
          title: Text('login page'),
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.dstATop),
                image: AssetImage('assets/bg.jpg')
              )
            ),
          padding: EdgeInsets.all(10.0),
          child: Center(child: SingleChildScrollView(
            child: Column(children: <Widget>[
            TextField(
              decoration: InputDecoration(
                labelText: 'email',
                fillColor: Colors.white,
                filled: true,
              ),
              keyboardType: TextInputType.emailAddress,
              onChanged: (String value) {
                setState(() {
                  _email = value;
                });
              },
            ),
            SizedBox(
              height: 10.0,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'password',
                fillColor: Colors.white,
                filled: true,
              ),
              obscureText: true,
              onChanged: (String value) {
                setState(() {
                  _password = value;
                });
              },
            ),
            SwitchListTile(
              title: Text('accept terms'),
              value: _acceptStatus,
              onChanged: (bool value) {
                setState(() {
                  _acceptStatus = value;
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
          ])
        ),
        ),
      )
    );
  }
}
