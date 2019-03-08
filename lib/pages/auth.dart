import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../scope-model/main.dart';
import '../model/auth.dart';

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
  AuthMode _authMode = AuthMode.Login;

  final GlobalKey<FormState> _loginForm = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();

  BoxDecoration _buildDecoratoin() {
    return BoxDecoration(
      image: DecorationImage(
        fit: BoxFit.cover,
        colorFilter: ColorFilter.mode(
          Colors.black.withOpacity(0.3), 
          BlendMode.dstATop
        ),
        image: AssetImage('assets/bg.jpg')),
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
      validator: (String value) {
        if (!RegExp(
                r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
            .hasMatch(value)) {
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
      controller: _passwordController,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Password should not be empty';
        }
      },
      onSaved: (String value) {
        _password = value;
      },
    );
  }

  Widget _buildConfirmPasswordTextFiled() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Confrim Password',
        fillColor: Colors.white,
        filled: true,
      ),
      obscureText: true,
      validator: (String value) {
        if (_passwordController.text != value) {
          return 'Password do not match';
        }
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

  void _submitForms(Function authenticate) async {
    if (!_loginForm.currentState.validate()) {
      return;
    }
    _loginForm.currentState.save();
    Map<String, dynamic> response = await authenticate(_email, _password, _authMode);
    if (response['status']) {
      Navigator.pushReplacementNamed(context, '/products');
    } else if (response['errmsg'] != null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('something wrong'),
            content: Text(response['errmsg']),
            actions: <Widget>[
              FlatButton(child: Text('ok'), 
              onPressed: (){
                Navigator.of(context).pop();
              },),
            ],
          );
        }
      );
    }
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
                    SizedBox(
                      height: 10.0,
                    ),
                    _authMode == AuthMode.Signup
                        ? _buildConfirmPasswordTextFiled()
                        : Container(),
                    _buildSwitchTextFiled(),
                    FlatButton(
                      child: Text('switch to ${_authMode == AuthMode.Login ? "Signup" : "Login"}'),
                      onPressed: () {
                        setState(() {
                          _authMode = _authMode == AuthMode.Login
                              ? AuthMode.Signup
                              : AuthMode.Login;
                        });
                      },
                    ),
                    ScopedModelDescendant(
                      builder: (BuildContext context, Widget child, MainModel model) {
                        return model.isLoading ? CircularProgressIndicator() : RaisedButton(
                          child: Text('login'),
                          onPressed: () => _submitForms(model.authenticate),
                        );
                      },
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
