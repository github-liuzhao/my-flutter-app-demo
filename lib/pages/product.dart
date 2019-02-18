/**
 * @file product详情
 */

import 'package:flutter/material.dart';
import 'dart:async';
import '../widget/ui_elements/title_default.dart';

class ProductPage extends StatelessWidget {
  final String title;
  final String image;
  final double price;
  final String desc;
  ProductPage(this.title, this.image, this.price, this.desc);
  // no matter if load data with route or if you load them by embedding them into anther widget,
  // use the constructor to pass data around

  // void _showWarningDilog(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text('提示'),
  //         content: Text('heheheheh'),
  //         actions: <Widget>[
  //           FlatButton(
  //             child: Text('cancel'),
  //             onPressed: () {
  //               Navigator.pop(context, 'cancel');
  //             },
  //           ),
  //           FlatButton(
  //             child: Text('ok'),
  //             onPressed: () {
  //               Navigator.pop(context, 'ok');
  //               Navigator.pop(context, true);
  //             },
  //           )
  //         ],
  //       );
  //     }
  //   ).then((value) {
  //     print('dialog $value');
  //   });
  // }

  Widget _buildTitleAndPrice(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        DefaultTitle(title),
        SizedBox(width: 10.0,),
        Text('\$' + price.toString(), style: TextStyle(fontFamily: 'Oswald', fontSize: 20.0),),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // Creates a widget that registers a callback to veto attempts by the user to dismiss the enclosing [ModalRoute].
    return WillPopScope(
      // 监听页面pop事件，可以阻止pop发生
      onWillPop: () {
        Navigator.pop(context, false);
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Container(
          // margin: EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center, // 垂直布局，cross即水平居中，外容器宽度默认跟内部最宽子元素宽度相同
              children: <Widget>[
                Image.asset(image), // the image is a widget which will take the full avalible width
                Container(
                  margin: EdgeInsets.all(10.0),
                  child: _buildTitleAndPrice()
                ),
                // how to pass infomation back to the last page?
                // pass true as value
                // Navigator.pop(context, true),
                // what if we press the physical or software back button?? ----- willPopScope
                Container(
                  child:
                    Text(
                      desc,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18.0, color: Colors.grey,),
                    ),
                ),
              ],
          ),
        ),
      ),
    );
  }
}
