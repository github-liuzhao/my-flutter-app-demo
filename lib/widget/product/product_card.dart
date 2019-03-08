
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../scope-model/main.dart';
import './product_price.dart';
import './product_location.dart';
import '../ui_elements/title_default.dart';
import '../../model/product.dart';

class ProductCard extends StatefulWidget {
  final Product product;
  final int index;
  final MainModel model;
  ProductCard(this.product, this.model, this.index);

  @override
  State<StatefulWidget> createState() {
    return _ProductCardState();
  }
}

class _ProductCardState extends State<ProductCard> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant(builder: (BuildContext context, Widget child, MainModel model) {
      return Card(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(10.0),
              // ??AssetImage / Image.assets
              child: FadeInImage(
                image: NetworkImage(widget.product.image),
                height: 300.0,
                fit: BoxFit.cover,
                placeholder: AssetImage('assets/img-placeholder.png'),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              DefaultTitle(widget.product.title),
              SizedBox(
                width: 10.0,
              ),
              ProductPrice(widget.product.price.toString()),
            ]),
            ProductLocation('beijing, china'),
            Text(widget.product.userEmail),
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                    icon: Icon(Icons.info_outline),
                    color: Theme.of(context).accentColor,
                    onPressed: () {Navigator.pushNamed<bool>(context, '/product/' + widget.product.id);}),
                IconButton(
                    icon: widget.product.isMyFavorite
                        ? Icon(Icons.favorite)
                        : Icon(Icons.favorite_border),
                    color: Theme.of(context).accentColor,
                    onPressed: () {
                      model.toggleDisplayedProductsList(widget.index, widget.product);
                    }),
              ],
            )
          ],
        ),
      );
    });
  }
}
