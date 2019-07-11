import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';

import '../../models/product.dart';
import './product_card.dart';

import '../../scoped-models/products.dart';

class Products extends StatelessWidget {
  Widget _builtProductList(List<Product> products) {
    if (products.length > 0) {
      return ListView.builder(
        itemBuilder: (BuildContext context, int index) =>
            ProductCard(products[index], index),
        itemCount: products.length,
      );
    } else {
      return Center(
        child: Text('No products found, please add some'),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ProductsModel>(
        builder: (BuildContext context, Widget child, ProductsModel model) {
      return _builtProductList(model.displayedProducts);
    });
  }
}
