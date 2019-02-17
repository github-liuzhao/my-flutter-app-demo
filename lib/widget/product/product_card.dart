import 'package:flutter/material.dart';
import './product_price.dart';

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
              Text(
                product['title'],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Oswald',
                  fontSize: 20.0
                ),
              ),
              SizedBox(
                width: 10.0,
              ),
              ProductPrice(product['price'].toString()),
            ]
          ),
          DecoratedBox(
            decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(4.0)),
            child: Padding(child: Text('Beijing, CHINA'), padding: EdgeInsets.all(2.0),)
          ),
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