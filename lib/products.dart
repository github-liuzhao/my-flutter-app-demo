import 'package:flutter/material.dart';

class Products extends StatelessWidget {
  final List<Map<String, dynamic>> products;
  final Function delProductItem;

  Products({this.products, this.delProductItem}) {
    print('[Products Widget] constructor');
  }

  Widget _buildProductItem(BuildContext context, int index) {
    return Card(
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(10.0),
            child: Image.asset(products[index]['image']),
          ),
          SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center, 
            children: <Widget>[
              Text(
                products[index]['title'],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Oswald',
                  fontSize: 20.0
                ),
              ),
              SizedBox(
                width: 10.0,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
                decoration: BoxDecoration(color: Theme.of(context).accentColor, borderRadius: BorderRadius.circular(4.0)),
                child: Text('\$${products[index]['price'].toString()}', style: TextStyle(color: Colors.white, fontSize: 12.0)),
              ),
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

  Widget _buildProductList() {
    Widget productList = Center(
      child: Text('product list is empty'),
    );
    if (products.length > 0) {
      productList = ListView.builder(
        // Creates a scrollable, linear array of widgets that are created on demand.
        itemBuilder: _buildProductItem,
        itemCount: products.length,
      );
    }
    return productList;
  }

  @override
  Widget build(BuildContext context) {
    print('[Products Widget] build');
    return _buildProductList();
  }
}
