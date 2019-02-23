import 'package:scoped_model/scoped_model.dart';
import '../model/product.dart';

class ProductsModel extends Model {
  List<Product> _products = [];
  int _selectedProductIndex;

  List<Product> get products {
    return List.from(_products);
  }

  int get selectProductIndex {
    return _selectedProductIndex;
  }

  void addProduct(Product product) {
    _products.add(product); 
  }

  void delProductItem(int index) {
    _products.removeAt(index);
  }

  void editProduct(Product product, int index) {
    _products[index] = product;
  }

  void selectProduct(int index){
    _selectedProductIndex = index;
  }
}
