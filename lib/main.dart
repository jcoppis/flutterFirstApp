import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  List<String> _products = ['Food Tester'];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('EasyList'),
        ),
        body: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(10.0),
              child: RaisedButton(
                onPressed: () {},
                child: Text('Add Product'),
              ),
            ),
            Column(
              children: _products
                  .map(
                    (e) => Card(
                          child: Column(
                            children: <Widget>[
                              Image.asset('assets/images/gatos.jpeg'),
                              Text(e)
                            ],
                          ),
                        ),
                  )
                  .toList(),
            )
          ],
        ),
      ),
    );
  }
}
