import 'dart:async';

import 'package:flutter/material.dart';

class ProductPage extends StatelessWidget {
  final String title;
  final String imageUrl;
  final double price;
  final String description;

  ProductPage(this.title, this.imageUrl, this.price, this.description);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        print('Back button pressed!');
        Navigator.pop(context, false);
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Product Detail'),
        ),
        body: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(imageUrl),
            Container(
              padding: EdgeInsets.all(10.0),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 26.0,
                  fontFamily: 'Anonymous',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Uniont Square, San Francisco',
                  style: TextStyle(fontFamily: 'Anonymous', color: Colors.grey),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  child: Text(
                    '|',
                    style:
                        TextStyle(fontFamily: 'Anonymous', color: Colors.grey),
                  ),
                ),
                Text(
                  '\$${price.toString()}',
                  style: TextStyle(fontFamily: 'Anonymous', color: Colors.grey),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              child: Text(description, textAlign: TextAlign.center,),
            ),
          ],
        ),
      ),
    );
  }
}
