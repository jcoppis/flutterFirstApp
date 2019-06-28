import 'package:flutter/material.dart';

import 'package:first_app/pages/product.dart';

class Products extends StatelessWidget {
  final List<Map<String, String>> products;
  final Function deleteProduct;

  Products(this.products, {this.deleteProduct});

  Widget _builtProductItem(BuildContext context, int index) {
    return Card(
      child: Column(
        children: <Widget>[
          Image.asset(products[index]['image']),
          Text(products[index]['title']),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                child: Text('Details'),
                onPressed: () => Navigator.push<bool>(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => ProductPage(
                            products[index]['title'], products[index]['image']),
                      ),
                    ).then((bool res) {
                      if (res) {
                        deleteProduct(index);
                      }
                    }),
              )
            ],
          )
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
