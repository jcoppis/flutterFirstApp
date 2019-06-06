import 'package:flutter/material.dart';

class Products extends StatelessWidget {
  final List<String> products;

  Products(this.products);

  Widget _builtProductItem(BuildContext context, int index) {
    return Card(
      child: Column(
        children: <Widget>[
          Image.asset('assets/images/gatos.jpeg'),
          Text(products[index])
        ],
      ),
    );
  }

  Widget _builtProductList() {
    if (products.length > 0) {
      return ListView.builder(
        itemBuilder: _builtProductItem,
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
    return _builtProductList();
  }
}
