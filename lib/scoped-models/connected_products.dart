import 'package:scoped_model/scoped_model.dart';

import '../models/product.dart';
import '../models/user.dart';

mixin ConnectedProducts on Model {
  int selectedProductIndex;
  List<Product> products = [];
  User authenticatedUser;

  void addProduct(
      String title, String description, double price, String image) {
    final Product newProduct = Product(
      title: title,
      description: description,
      price: price,
      image: image,
      userId: authenticatedUser.id,
      userEmail: authenticatedUser.email,
    );
    products.add(newProduct);
    selectedProductIndex = null;

    notifyListeners();
  }
}
