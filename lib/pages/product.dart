/**
 * @file product详情
 */

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'dart:async';
import '../scope-model/main.dart';
import '../widget/ui_elements/title_default.dart';
import '../model/product.dart';

class ProductPage extends StatelessWidget {
  final int productIndex;
  ProductPage(this.productIndex);
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

  Widget _buildTitleAndPrice(Product product){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        DefaultTitle(product.title),
        SizedBox(width: 10.0,),
        Text('\$' + product.price.toString(), style: TextStyle(fontFamily: 'Oswald', fontSize: 20.0),),
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
      child: ScopedModelDescendant(builder: (BuildContext context, Widget child, MainModel model){
        final Product product = model.products[productIndex];
        return Scaffold(
          appBar: AppBar(
            title: Text(product.title),
          ),
          body: Container(
            // margin: EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center, // 垂直布局，cross即水平居中，外容器宽度默认跟内部最宽子元素宽度相同
                children: <Widget>[
                  Image.asset(product.image), // the image is a widget which will take the full avalible width
                  Container(
                    margin: EdgeInsets.all(10.0),
                    child: _buildTitleAndPrice(product)
                  ),
                  // how to pass infomation back to the last page?
                  // pass true as value
                  // Navigator.pop(context, true),
                  // what if we press the physical or software back button?? ----- willPopScope
                  Container(
                    child:
                      Text(
                        product.desc,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18.0, color: Colors.grey,),
                      ),
                  ),
                  Container(
                    child:
                      Text(
                        product.userEmail,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18.0, color: Colors.grey,),
                      ),
                  ),
                ],
              ),
          ),
        );
      }),
    );
  }
}
