import '../scoped-models/connected_products.dart';

import '../models/product.dart';

mixin ProductsModel on ConnectedProducts {
  bool _showFavorites = false;

  List<Product> get allProducts {
    // copia de la lista
    return List.from(products);
  }

  List<Product> get displayedProducts {
    if (_showFavorites) {
      return products.where((Product p) => p.isFavorite).toList();
    } else {
      return List.from(products);
    }
  }

  int get selProductIndex {
    return selectedProductIndex;
  }

  Product get selectedProduct {
    return selectedProductIndex == null ? null : products[selectedProductIndex];
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
    products[selectedProductIndex] = updatedProduct;
    selectedProductIndex = null;

    notifyListeners();
  }

  void deleteProduct() {
    products.removeAt(selectedProductIndex);
    selectedProductIndex = null;

    notifyListeners();
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

    products[selectedProductIndex] = updatedProduct;
    notifyListeners();

    selectedProductIndex = null;
  }

  void selectProduct(int index) {
    selectedProductIndex = index;
  }

  void toogleDisplayMode() {
    _showFavorites = !_showFavorites;

    notifyListeners();
  }
}
