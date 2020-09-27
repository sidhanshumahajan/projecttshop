import 'package:flutter/material.dart';

class AllCategories extends StatelessWidget {
  static const routeName = '/allCategories';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text('All Categories'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(),
    );
  }
}
