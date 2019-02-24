import 'package:scoped_model/scoped_model.dart';
import '../model/product.dart';

class ProductsModel extends Model {
  // 私有变量，除了通过函数不可直接操作
  List<Product> _products = [];

  // On the other hand, an integer also has some built-in methods
  // but all these methods return a new integer
  // So I don't have a problem if any one interacts with this integer from outside because there is no
  // method which would edit the integer stored in here.
  int _selectedProductIndex;

  bool _showFavoriteListStatus = false;

  // return a new list and not the old list or access to the old list
  // and this is done with this line and that is just important to ensure that we can never edit the list
  // inside of products model from outside other than
  // by calling add product.
  List<Product> get products {
    return List.from(_products);
  }

  int get selectProductIndex {
    return _selectedProductIndex;
  }

  bool get showFavoriteListStatus {
    return _showFavoriteListStatus;
  }

  List<Product> get favoriteList {
    if(_showFavoriteListStatus){
      return _products.where((Product product) => product.isMyFavorite == true).toList();
    }
    return List.from(_products);
  }

  // I'm not returning the list so I don't need to worry about that but every element in that list is an
  // instance of my product model, so of this model and we could theoretically edit this from outside but only
  // theoretically, because I set every property in here to a final property, I can't edit it without getting
  // an error.
  Product get selectedProduct {
    if (_selectedProductIndex == null) {
      return null;
    }
    return _products[_selectedProductIndex];
  }

  void toggleFavoritListStatus(){
    _showFavoriteListStatus = !_showFavoriteListStatus;
    notifyListeners();
  }

  void toggleFavoritProduct(int index) {
    final curProduct = _products[index];
    final newProduct = Product(
        title: curProduct.title,
        desc: curProduct.desc,
        price: curProduct.price,
        image: curProduct.image,
        isMyFavorite: !curProduct.isMyFavorite);
    _products[index] = newProduct;
    notifyListeners();
  }

  void addProduct(Product product) {
    _products.add(product);
    notifyListeners();
  }

  void delProductItem(int index) {
    _products.removeAt(index);
    notifyListeners();
  }

  void editProduct(Product product, int index) {
    _products[index] = product;
    notifyListeners();
  }

  void selectProduct(int index) {
    _selectedProductIndex = index;
    notifyListeners();
  }
}
