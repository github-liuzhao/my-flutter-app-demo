/**
 * collecting Models & Sharing Data
 */

import 'package:scoped_model/scoped_model.dart';
import '../model/user.dart';
import '../model/product.dart';

mixin CollectedProducts on Model {
  List<Product> _products = [];
  User _authenticatedUser;

  void addProduct({String title, String desc, double price, String image, bool isMyFavorite}) {
    // 这里不直接传入新的Product实例是因为Product所有属性都是final，不可修改，我们需要在这里增加user信息
    final Product product = Product(
        title: title,
        desc: desc,
        price: price,
        image: image,
        isMyFavorite: isMyFavorite,
        userEmail: _authenticatedUser.email,
        userId: _authenticatedUser.id);
    _products.add(product);
    notifyListeners();
  }
}

// 用户信息model
mixin UserModel on CollectedProducts{
  void login(String email, String password){
    _authenticatedUser = User(id: '435GDSF', email: email, password: password);
  }
}

// 产品信息model
mixin ProductsModel on CollectedProducts {

  // On the other hand, an integer also has some built-in methods
  // but all these methods return a new integer
  // So I don't have a problem if any one interacts with this integer from outside because there is no
  // method which would edit the integer stored in here.
  // int _selectedProductIndex;

  bool _showFavoriteListStatus = false;

  // return a new list and not the old list or access to the old list
  // and this is done with this line and that is just important to ensure that we can never edit the list
  // inside of products model from outside other than
  // by calling add product.
  List<Product> get products {
    return List.from(_products);
  }

  // int get selectProductIndex {
  //   return _selectedProductIndex;
  // }

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
  // Product get selectedProduct {
  //   if (_selectedProductIndex == null) {
  //     return null;
  //   }
  //   return products[_selectedProductIndex];
  // }

  void toggleFavoritListStatus(){
    _showFavoriteListStatus = !_showFavoriteListStatus;
    notifyListeners();
  }

  void toggleFavoritProduct(int index) {
    final curProduct = products[index];
    final newProduct = Product(
        title: curProduct.title,
        desc: curProduct.desc,
        price: curProduct.price,
        image: curProduct.image,
        userEmail: curProduct.userEmail,
        userId: curProduct.userId,
        isMyFavorite: !curProduct.isMyFavorite);
    _products[index] = newProduct;
    notifyListeners();
  }



  void delProductItem(int index) {
    _products.removeAt(index);
    notifyListeners();
  }

  void editProduct(int index, {String title, String desc, double price, String image, bool isMyFavorite}) {
    final Product product = Product(
        title: title,
        desc: desc,
        price: price,
        image: image,
        isMyFavorite: isMyFavorite,
        userEmail: _authenticatedUser.email,
        userId: _authenticatedUser.id);
    _products[index] = product;
    notifyListeners();
  }

  // void selectProduct(int index) {
  //   _selectedProductIndex = index;
  //   notifyListeners();
  // }
}
