import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../scope-model/products.dart';
import './product_price.dart';
import './product_location.dart';
import '../ui_elements/title_default.dart';
import '../../model/product.dart';

class ProductCard extends StatelessWidget{

  final int index;
  ProductCard(this.index);

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant(builder: (BuildContext context, Widget child, ProductsModel model){
      final Product product = model.products[index];
      return Card(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(10.0),
              child: Image.asset(product.image),
            ),
            SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center, 
              children: <Widget>[
                DefaultTitle(product.title),
                SizedBox(
                  width: 10.0,
                ),
                ProductPrice(product.price.toString()),
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
                IconButton(
                    icon: product.isMyFavorite ? Icon(Icons.favorite) : Icon(Icons.favorite_border),
                    color: Theme.of(context).accentColor,
                    onPressed: () {
                      model.toggleFavoritProduct(index);
                    }
                  ),
              ],
            )
          ],
        ),
      );
    });
  }
}