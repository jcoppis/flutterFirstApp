import 'dart:convert';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;

import '../models/product.dart';
import '../models/user.dart';

mixin ConnectedProductsModel on Model {
  int _selectedProductIndex;
  List<Product> _products = [];
  User _authenticatedUser;

  void addProduct(
      String title, String description, double price, String image) {
    final Map<String, dynamic> productData = {
      'title': title,
      'description': description,
      'image':
          'http://images4.fanpop.com/image/photos/16000000/Beautiful-Cat-cats-16096437-1280-800.jpg',
      'price': price,
      'userId': _authenticatedUser.id,
      'userEmail': _authenticatedUser.email
    };
    http
        .post('https://jc-flutter-products.firebaseio.com/products.json',
            body: json.encode(productData))
        .then((http.Response response) {
      final Map<String, dynamic> responseData = json.decode(response.body);

      final Product newProduct = Product(
        id: responseData['name'],
        title: title,
        description: description,
        price: price,
        image: image,
        userId: _authenticatedUser.id,
        userEmail: _authenticatedUser.email,
      );
      _products.add(newProduct);
      notifyListeners();
    });
  }
}

mixin ProductsModel on ConnectedProductsModel {
  bool _showFavorites = false;

  List<Product> get allProducts {
    // copia de la lista
    return List.from(_products);
  }

  List<Product> get displayedProducts {
    if (_showFavorites) {
      return _products.where((Product p) => p.isFavorite).toList();
    } else {
      return List.from(_products);
    }
  }

  int get selProductIndex {
    return _selectedProductIndex;
  }

  Product get selectedProduct {
    return _selectedProductIndex == null
        ? null
        : _products[_selectedProductIndex];
  }

  bool get displayFavoritesOnly {
    return _showFavorites;
  }

  void updateProduct(
      String title, String description, double price, String image) {
    final Product updatedProduct = Product(
      title: title,
      description: description,
      price: price,
      image: image,
      userId: selectedProduct.userId,
      userEmail: selectedProduct.userEmail,
    );
    _products[_selectedProductIndex] = updatedProduct;

    notifyListeners();
  }

  void deleteProduct() {
    _products.removeAt(_selectedProductIndex);

    notifyListeners();
  }

  void fetchProducts() {
    http
        .get('https://jc-flutter-products.firebaseio.com/products.json')
        .then((http.Response response) {
      final List<Product> fetchedProductList = [];

      final Map<String, dynamic> productListData = json.decode(response.body);

      productListData.forEach((String productId, dynamic productData) {
        final Product product = Product(
          id: productId,
          title: productData['title'],
          description: productData['description'],
          image: productData['image'],
          price: productData['price'],
          userId: productData['userId'],
          userEmail: productData['userEmail'],
        );
        fetchedProductList.add(product);
      });
      _products = fetchedProductList;
      notifyListeners();
    });
  }

  void toogleFavorite() {
    final Product updatedProduct = Product(
      title: selectedProduct.title,
      description: selectedProduct.description,
      image: selectedProduct.image,
      price: selectedProduct.price,
      userId: selectedProduct.userId,
      userEmail: selectedProduct.userEmail,
      isFavorite: !selectedProduct.isFavorite,
    );

    _products[_selectedProductIndex] = updatedProduct;

    notifyListeners();
  }

  void selectProduct(int index) {
    _selectedProductIndex = index;
  }

  void toogleDisplayMode() {
    _showFavorites = !_showFavorites;

    notifyListeners();
  }
}

mixin UserModel on ConnectedProductsModel {
  void login(String email, String password) {
    _authenticatedUser = User(id: 'a', email: email, password: password);
  }
}
