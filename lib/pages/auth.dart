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

  final GlobalKey<FormState> _loginForm =GlobalKey<FormState>();

  BoxDecoration _buildDecoratoin() {
    return BoxDecoration(
      image: DecorationImage(
        fit: BoxFit.cover,
        colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.dstATop),
        image: AssetImage('assets/bg.jpg')
      ),
    );
  }

  Widget _buildEmailTextFiled() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'email',
        fillColor: Colors.white,
        filled: true,
      ),
      keyboardType: TextInputType.emailAddress,
      validator: (String value){
        if(!RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?").hasMatch(value)){
          return 'Email address is not right';
        }
      },
      onSaved: (String value) {
        _email = value;
      },
    );
  }

  Widget _buildPasswordTextFiled() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'password',
        fillColor: Colors.white,
        filled: true,
      ),
      obscureText: true,
      validator: (String value){
        if(value.isEmpty){
          return 'Password should not be empty';
        }
      },
      onSaved: (String value) {
        _password = value;
      },
    );
  }

  Widget _buildSwitchTextFiled() {
    return SwitchListTile(
      title: Text('accept terms'),
      value: _acceptStatus,
      onChanged: (bool value) {
        setState(() {
          _acceptStatus = value;
        });
      },
    );
  }

  void _submitForms() {
    print(_email);
    print(_password);
    if(!_loginForm.currentState.validate()){
      return;
    }
    _loginForm.currentState.save();
    Navigator.pushReplacementNamed(context, '/products');
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 750.0 ? 700.0 : deviceWidth * 0.9;

    return Scaffold(
      // Scaffold creates a new 'page' in you app
      appBar: AppBar(
        title: Text('login page'),
      ),
      body: Container(
        decoration: _buildDecoratoin(),
        padding: EdgeInsets.all(10.0),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              width: targetWidth,
              child: Form(
                key: _loginForm,
                child: Column(
                  children: <Widget>[
                    _buildEmailTextFiled(),
                    SizedBox(
                      height: 10.0,
                    ),
                    _buildPasswordTextFiled(),
                    _buildSwitchTextFiled(),
                    RaisedButton(
                      child: Text('login'),
                      onPressed: _submitForms,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
