/**
 * @file product详情
 */

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'dart:async';
import '../scope-model/main.dart';
import '../widget/ui_elements/title_default.dart';
import '../model/product.dart';

class ProductPage extends StatefulWidget {
  final String productId;
  final MainModel model;
  ProductPage(this.productId, this.model);

  @override
  State<StatefulWidget> createState() {
    return _ProductPageState();
  }
}
  
class _ProductPageState extends State<ProductPage>{
  Product product;

  @override
  void initState() {
    widget.model.getProduct(widget.productId).then((Product prodct){
      setState((){
        product = prodct;
      });
      print('fetched product data');
    });
    super.initState();
  }

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
    print('building product content');
    // Creates a widget that registers a callback to veto attempts by the user to dismiss the enclosing [ModalRoute].
    return WillPopScope(
      // 监听页面pop事件，可以阻止pop发生
      onWillPop: () {
        Navigator.pop(context, false);
        return Future.value(false);
      },
      child: ScopedModelDescendant(builder: (BuildContext context, Widget child, MainModel model){
        return Scaffold(
          appBar: AppBar(
            title: model.isLoading ? Text('...') : Text(product.title),
          ),
          body: model.isLoading ? Center(child: CircularProgressIndicator(),) : Container(
            // margin: EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center, // 垂直布局，cross即水平居中，外容器宽度默认跟内部最宽子元素宽度相同
                children: <Widget>[
                  Image.network(product.image), // the image is a widget which will take the full avalible width
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
