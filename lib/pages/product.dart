import 'package:flutter/material.dart';

class ProductPage extends StatelessWidget {

  final String title;
  final String image;
  ProductPage(this.title, this.image);
  // no matter if load data with route or if you load them by embedding them into anther widget, 
  // use the constructor to pass data around

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  child: Text('go back'),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ],
          ),
      );
  }
}
