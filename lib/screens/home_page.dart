import 'package:flutter/material.dart';
import 'package:ktlabs/providers/cart_provider.dart';
import 'package:ktlabs/screens/cart_screen.dart';
import 'package:ktlabs/screens/components/product_grid.dart';
import 'package:ktlabs/util/search_bar.dart';
import 'package:ktlabs/widgets/badge.dart';
import 'package:ktlabs/widgets/drawer.dart';
import 'package:ktlabs/widgets/horizontal_list_view.dart';
import 'package:ktlabs/widgets/image_carosuel.dart';
import 'package:provider/provider.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text('Shop App'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: DataSearch(),
              );
            },
          ),
          Consumer<Cart>(
            builder: (context, cartData, ch) => Badge(
              child: ch,
              color: Colors.red,
              value: cartData.itemCount.toString(),
            ),
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          //image Carosuel start here
          imageCarosuel,
          //padding between carosuel and text
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text('Category'),
            ),
          ),
          // categories list view start here
          HorizontalListView(),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text('Recent Products'),
            ),
          ),
          Flexible(
            child: ProductsGrid(),
          ),
        ],
      ),
      drawer: AppDrawer(),
    );
  }
}
