/**
 * collecting Models & Sharing Data
 */

import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import '../model/user.dart';
import '../model/product.dart';

mixin CollectedProducts on Model {
  List<Product> _products = [];
  User _authenticatedUser;
  bool _isLoading = false;

  Future<Null> fetchProduct() {
    _isLoading = true;
    notifyListeners();
    return http.get('http://localhost:3000/products').then((http.Response res) {
      final List<Product> fetchedProductsList = [];
      final List<dynamic> productsListData = json.decode(res.body);
      if (productsListData == null) {
        _isLoading = false;
        notifyListeners();
        return;
      }
      productsListData.forEach((productData) {
        final Product product = Product(
            id: productData['id'],
            title: productData['title'],
            desc: productData['desc'],
            userEmail: productData['userEmail'],
            userId: productData['userId'],
            price: productData['price'].toDouble(),
            image: productData['image']);
        fetchedProductsList.add(product);
      });
      _products = fetchedProductsList;
      _isLoading = false;
      notifyListeners();
    });
  }

  Future<Null> addProduct(
      {String title,
      String desc,
      double price,
      String image,
      bool isMyFavorite}) {
    _isLoading = true;
    notifyListeners();
    final Map<String, dynamic> productData = {
      'title': title,
      'price': price,
      'desc': desc,
      'image':
          'http://www.360changshi.com/uploadfile/2016/0120/20160120070821101.jpg',
      'userEmail': _authenticatedUser.email,
      'userId': _authenticatedUser.id
    };

    return http.post('http://localhost:3000/products',
        body: json.encode(productData),
        // convert a map to json
        headers: {
          'content-type': 'application/json'
        }).then((http.Response res) {
      final Map<String, dynamic> productData = json.decode(res.body);
      final Product product = Product(
          id: productData['id'],
          title: title,
          desc: desc,
          price: price,
          image: image,
          isMyFavorite: isMyFavorite,
          userEmail: _authenticatedUser.email,
          userId: _authenticatedUser.id);
      _products.add(product);
      _isLoading = false;
      notifyListeners();
    });
  }
}

// 用户信息model
mixin UserModel on CollectedProducts {
  void login(String email, String password) {
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

  List<Product> get displayedProductsList {
    if (_showFavoriteListStatus) {
      return _products
          .where((Product product) => product.isMyFavorite == true)
          .toList();
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

  void toggleFavoritListStatus() {
    _showFavoriteListStatus = !_showFavoriteListStatus;
    notifyListeners();
  }

  void toggleDisplayedProductsList(int index) {
    final curProduct = products[index];
    final newProduct = Product(
        id: curProduct.id,
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

  void delProductItem(int id) {
    // _products.removeAt(index);
    _isLoading = true;
    notifyListeners();
    http.delete('http://localhost:3000/products/$id').then((http.Response res){
      _isLoading = false;
      notifyListeners();
    });
  }

  Future<Product> getProduct(int id) {
    _isLoading = true;
    notifyListeners();
    return http
        .get('http://localhost:3000/products/$id')
        .then((http.Response res) {
      final Map<String, dynamic> productData = json.decode(res.body);
      final Product product = Product(
        title: productData['title'],
        desc: productData['desc'],
        id: productData['id'],
        price: productData['price'].toDouble(),
        image: productData['image'],
        userEmail: productData['userEmail'],
        isMyFavorite: productData['isMyFavorite'],
        userId: productData['userId'],
      );
      _isLoading = false;
      notifyListeners();
      return product;
    });
  }

  Future<Null> updateProduct(int id,
      {String title,
      String desc,
      double price,
      String image,
      bool isMyFavorite}) {
    _isLoading = true;
    notifyListeners();
    final Map<String, dynamic> updateProdct = {
      'title': title,
      'desc': desc,
      'image': image,
      'price': price,
      'isMyFavorite': isMyFavorite,
      'userEmail': _authenticatedUser.email,
      'userId': _authenticatedUser.id
    };
    return http.put('http://localhost:3000/products/$id',
        body: json.encode(updateProdct),
        headers: {
          'content-type': 'application/json'
        }).then((http.Response res) {
      // final Product product = Product(
      //     id: id,
      //     title: title,
      //     desc: desc,
      //     price: price,
      //     image: image,
      //     isMyFavorite: isMyFavorite,
      //     userEmail: _authenticatedUser.email,
      //     userId: _authenticatedUser.id);
      // _products[index] = product;
      _isLoading = false;
      notifyListeners();
    });
  }

  // void selectProduct(int index) {
  //   _selectedProductIndex = index;
  //   notifyListeners();
  // }
}

mixin UtilityModel on CollectedProducts {
  bool get isLoading {
    return _isLoading;
  }
}
