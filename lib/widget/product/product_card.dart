import 'package:flutter/material.dart';
import './product_price.dart';
import './product_location.dart';
import '../ui_elements/title_default.dart';


class ProductCard extends StatelessWidget{

  final Map<String, dynamic> product;
  final int index;

  ProductCard(this.product, this.index);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(10.0),
            child: Image.asset(product['image']),
          ),
          SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center, 
            children: <Widget>[
              DefaultTitle(product['title']),
              SizedBox(
                width: 10.0,
              ),
              ProductPrice(product['price'].toString()),
            ]
          ),
          ProductLocation('beijing, china'),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.info_outline),
                color: Theme.of(context).accentColor,
                onPressed: () {
                  Navigator.pushNamed<bool>(context, '/product/' + index.toString());
                  // .then((bool value) {
                  //   if (value == true) {
                  //     print('del');
                  //     delProductItem(index);
                  //   }
                  // });
                }
              ),
              FlatButton(
                child: Icon(Icons.favorite_border),
                textColor: Theme.of(context).accentColor,
                onPressed: () {
                }
              )
            ],
          )
        ],
      ),
    );
  }
}