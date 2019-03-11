import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../scope-model/main.dart';

class LogoutButton extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant(builder: (BuildContext context, Widget child, MainModel model){
      return ListTile(
        leading: Icon(Icons.exit_to_app),
        title:Text('Login out'),
        onTap: (){
          // issue: https://github.com/flutter/flutter/issues/25047
          Navigator.of(context).pop();
          model.logout();
        },
      );
    },);
  }
}