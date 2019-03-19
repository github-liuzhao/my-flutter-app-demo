/**
 * collecting Models & Sharing Data
 */

import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';
import 'dart:convert';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/user.dart';
import '../model/product.dart';
import '../model/auth.dart';

mixin CollectedProducts on Model {
  List<Product> _products = [];
  User _authenticatedUser;
  bool _isLoading = false;
}

// 用户信息model
mixin UserModel on CollectedProducts {
  // rxdart
  PublishSubject<bool> _userSubject = PublishSubject();
  Timer _authTimer;

  User get user{
    return _authenticatedUser;
  }
  
  PublishSubject<bool> get userSubject {
    return _userSubject;
  }

  Future<Map<String, dynamic>> authenticate(
    String email, 
    String password,
    [AuthMode mode = AuthMode.Login]
  ) async {
    final Map<String, dynamic> _authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };
    _isLoading = true;
    notifyListeners();
    http.Response response;
    String authApi = 'https://www.googleapis.com/identitytoolkit/v3/relyingparty/verifyPassword?key=AIzaSyCvfxfRe_1ekN9D4LIXJCT3F4JR7_S8ArE';
    if (mode == AuthMode.Signup) {
      authApi = 'https://www.googleapis.com/identitytoolkit/v3/relyingparty/signupNewUser?key=AIzaSyCvfxfRe_1ekN9D4LIXJCT3F4JR7_S8ArE';
    }

    try {

      response = await http.post(authApi,
        body: json.encode(_authData),
        headers: {'Content-Type': 'application/json'}
      );
      bool status = false;
      String errmsg = 'login error';
      print('responseData $response');
      Map<String, dynamic> responseData = json.decode(response.body);
      if (responseData.containsKey('idToken')) {
        _authenticatedUser = User(
          id: responseData['localId'],
          email: email,
          token: responseData['idToken']
        );
        _userSubject.add(true);
        final DateTime now = DateTime.now();
        final DateTime expiryTime = now.add(Duration(seconds: int.parse(responseData['expiresIn'])));
        setAuthTimeout(int.parse(responseData['expiresIn']));
        // 存储登陆信息
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('userEmail', email);
        await prefs.setString('localId', responseData['localId']);
        await prefs.setString('idToken', responseData['idToken']);
        // 存储账号过期时间
        await prefs.setString('expiryTime', expiryTime.toIso8601String());
        status = true;
        errmsg = '';
      } else {
        errmsg = responseData['error']['message'];
      }

      _isLoading = false;
      notifyListeners();
      return {'status': status, 'errmsg': errmsg};
      
    } catch (e) {

      _isLoading = false;
      notifyListeners();
      return {'status': false, 'errmsg': 'SocketException: OS Error: Connection reset by peer'};
    }
   
  }

  // 已登陆用户通过本地有效token自动登陆
  void autoAuthenticate() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String idToken = prefs.getString('idToken');
    String expiryTime = prefs.getString('expiryTime');
    if(idToken != null){
      final DateTime now = DateTime.now();
      final parsedExpiryTime = DateTime.parse(expiryTime);
      // 判断账号是否过期
      if(parsedExpiryTime.isBefore(now)){
        _authenticatedUser = null;
        notifyListeners();
        return;
      }
      final String userEmail = prefs.getString('userEmail');
      final String localId = prefs.getString('localId');
      final int tokenLifespan = parsedExpiryTime.difference(now).inSeconds;
      _authenticatedUser = User(
        id: localId,
        email: userEmail,
        token: idToken
      );
      print('autoAuthenticate ${_authenticatedUser.email}');
      _userSubject.add(true);
      setAuthTimeout(tokenLifespan);
    }
  }

  Future<Null> logout() async {
    _authenticatedUser = null;
    // 清理计时
    _authTimer.cancel();
    _userSubject.add(false);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('userEmail');
    prefs.remove('localId');
    prefs.remove('idToken');
    print('user logout');
  }

  void setAuthTimeout(int time){
    _authTimer = Timer(Duration(seconds: time), logout);
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

  void toggleDisplayedProductsList(int index, Product product) async{

    final bool newFavoriteStatus = !product.isMyFavorite;
    final newProduct = Product(
      id: product.id,
      title: product.title,
      desc: product.desc,
      price: product.price,
      image: product.image,
      userEmail: product.userEmail,
      userId: product.userId,
      isMyFavorite: newFavoriteStatus);
    _products[index] = newProduct;
    notifyListeners();

    http.Response response;

    if (newFavoriteStatus) {
      response = await http.put(
        'https://aapi-e2ab8.firebaseio.com/products/${product.id}/wishlistusers/${_authenticatedUser.id}.json?auth=${_authenticatedUser.token}',
        body: json.encode(true)
      );
    } else {
      response = await http.delete(
        'https://aapi-e2ab8.firebaseio.com/products/${product.id}/wishlistusers/${_authenticatedUser.id}.json?auth=${_authenticatedUser.token}',
      );
    }

    if(response.statusCode != 200 && response.statusCode != 201){
      final newProduct = Product(
        id: product.id,
        title: product.title,
        desc: product.desc,
        price: product.price,
        image: product.image,
        userEmail: product.userEmail,
        userId: product.userId,
        isMyFavorite: !newFavoriteStatus);
      _products[index] = newProduct;
      notifyListeners();
    }
  }

  Future<Null> delProductItem(String id, int index) async{
    _isLoading = true;
    _products.removeAt(index);
    notifyListeners();
    await http.delete('https://aapi-e2ab8.firebaseio.com/products/$id.json?auth=${_authenticatedUser.token}');
    _isLoading = false;
    notifyListeners();
  }

  Future<Null> fetchProduct() async {
    _isLoading = true;
    notifyListeners();

    http.Response response =
        await http.get('https://aapi-e2ab8.firebaseio.com/products.json?auth=${_authenticatedUser.token}');

    final List<Product> fetchedProductsList = [];
    final Map<String, dynamic> responseData = json.decode(response.body);
    if (responseData == null || responseData['error'] != null) {
      _isLoading = false;
      notifyListeners();
      return;
    }

    responseData.forEach((String productId, dynamic productData) {
      final Product product = Product(
          id: productId,
          title: productData['title'],
          desc: productData['desc'],
          userEmail: productData['userEmail'],
          userId: productData['userId'],
          price: productData['price'].toDouble(),
          isMyFavorite: productData['wishlistusers'] == null ? false : (productData['wishlistusers'] as Map<String, dynamic>).containsKey(_authenticatedUser.id),
          image: productData['image']);
      fetchedProductsList.add(product);
    });

    _products = fetchedProductsList;
    _isLoading = false;
    notifyListeners();
  }

  Future<Null> addProduct(
      {String title,
      String desc,
      double price,
      String image,
      bool isMyFavorite}) async {
    _isLoading = true;
    notifyListeners();
    final Map<String, dynamic> productData = {
      'title': title,
      'price': price,
      'desc': desc,
      'image':
          'http://www.360changshi.com/uploadfile/2016/0120/20160120070821101.jpg',
      'isMyFavorite': isMyFavorite,
      'userEmail': _authenticatedUser.email,
      'userId': _authenticatedUser.id
    };

    http.Response response = await http.post(
        'https://aapi-e2ab8.firebaseio.com/products.json?auth=${_authenticatedUser.token}',
        body: json.encode(productData),
        headers: {'content-type': 'application/json'});
    final Map<String, dynamic> responseData = json.decode(response.body);
    final Product product = Product(
        id: responseData['id'],
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
  }

  Future<Product> getProduct(String id) async {
    _isLoading = true;
    notifyListeners();
    http.Response response =
        await http.get('https://aapi-e2ab8.firebaseio.com/products/$id.json?auth=${_authenticatedUser.token}');
    final Map<String, dynamic> responseData = json.decode(response.body);
    final Product product = Product(
      title: responseData['title'],
      desc: responseData['desc'],
      id: responseData['id'],
      price: responseData['price'].toDouble(),
      image: responseData['image'],
      userEmail: responseData['userEmail'],
      isMyFavorite: responseData['isMyFavorite'],
      userId: responseData['userId'],
    );
    _isLoading = false;
    notifyListeners();
    return product;
  }

  Future<Null> updateProduct(String id,
      {String title,
      String desc,
      double price,
      bool isMyFavorite,
      String image,
      String userEmail,
      String userId}) async {
    _isLoading = true;
    notifyListeners();
    final Map<String, dynamic> updateProdct = {
      'title': title,
      'desc': desc,
      'price': price,
      'userEmail':userEmail,
      'userId':userId,
      'image': image,
      'isMyFavorite': isMyFavorite
    };
    await http.put(
      'https://aapi-e2ab8.firebaseio.com/products/$id.json?auth=${_authenticatedUser.token}',
      body: json.encode(updateProdct),
      headers: {'content-type': 'application/json'});
    _isLoading = false;
    notifyListeners();
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
