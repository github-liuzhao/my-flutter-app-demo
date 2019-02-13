import 'package:flutter/material.dart';
import 'dart:async';

class ProductPage extends StatelessWidget {

  final String title;
  final String image;
  ProductPage(this.title, this.image);
  // no matter if load data with route or if you load them by embedding them into anther widget, 
  // use the constructor to pass data around

  @override
  Widget build(BuildContext context) {
    // Creates a widget that registers a callback to veto attempts by the user to dismiss the enclosing [ModalRoute].
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context, false);
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: 
          Column(
            crossAxisAlignment: CrossAxisAlignment.center, // 垂直布局，cross即水平居中，外容器宽度默认跟内部最宽子元素宽度相同
            children: <Widget>[
              Image.asset(image), // the image is a widget which will take the full avalible width
              Container(
                margin: EdgeInsets.all(10.0), 
                child: Text(title),
              ),
              Container(
                margin: EdgeInsets.all(10.0),
                child: RaisedButton(
                  child: Text('del'),
                  // how to pass infomation back to the last page?
                  // pass true as value
                  // what if we press the physical or software back button?? ----- willPopScope
                  onPressed: () => Navigator.pop(context, true),
                ),
              ),
            ],
          ),
      ),
    );
  }
}
