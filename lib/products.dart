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
          SizedBox(height: 10.0,),
          Text(products[index]['title'], style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Oswald', fontSize: 20.0), ),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                child: Text('check details'),
                onPressed: () {
                  Navigator.pushNamed<bool>(context, '/product/' + index.toString())
                  .then((bool value) {
                    if(value == true){
                      print('del');
                      delProductItem(index);
                    }
                  });

                  // MaterialPageRoute(
                  //   builder: (BuildContext context) => ProductPage(products[index]['title'], products[index]['image'])
                  // )
                  // MaterialPageRoute自带转场动画
                  // no matter if load data with route or if you load them by embedding them into anther widget, 
                  // use the constructor to pass data around
                  // Navigator.pushNamed<bool>(context, '/product/' + index.toString())
                  // .then((bool value) {
                  // this is essentially an ongoing operation where we can listen to when the page is removed
                    // if(value == true){
                    //   delProductItem(index);
                    // }
                //}), 
              })
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
