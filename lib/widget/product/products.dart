import 'package:flutter/material.dart';
import './product_card.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../model/product.dart';
import '../../scope-model/main.dart';

class Products extends StatelessWidget {

  Products() {
    print('[Products Widget] constructor');
  }

  Widget _buildProductList(List<Product> products, Model model) {
    return ListView.builder(
        // Creates a scrollable, linear array of widgets that are created on demand.
        itemBuilder: (BuildContext context, int index){
          return ProductCard(products[index], model, index);
        },
        itemCount: products.length,
      );
  }

  @override
  Widget build(BuildContext context) {
    print('[Products Widget] build');
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model){
        return _buildProductList(model.displayedProductsList, model);
      },
    );
  }
}
