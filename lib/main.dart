import 'package:flutter/material.dart';
import 'package:ktlabs/admin/screens/admin.dart';
import 'package:ktlabs/providers/cart_provider.dart';
import 'package:ktlabs/providers/catalogue.dart';
import 'package:ktlabs/providers/order_provider.dart';
import 'package:ktlabs/providers/product_provider.dart';
import 'package:ktlabs/screens/all_categories.dart';
import 'package:ktlabs/screens/cart_screen.dart';
import 'package:ktlabs/screens/order_screen.dart';
import 'package:ktlabs/screens/product_detail_screen.dart';
import 'package:ktlabs/screens/wishlist_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => Catelogue()),
        ChangeNotifierProvider(create: (ctx) => Products()),
        ChangeNotifierProvider(create: (ctx) => Cart()),
        ChangeNotifierProvider(create: (ctx) => Orders()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AdminPage(),
        title: 'shopApp',
        routes: {
          CartScreen.routeName: (ctx) => CartScreen(),
          OrderScreen.routeName: (ctx) => OrderScreen(),
          AllCategories.routeName: (ctx) => AllCategories(),
          WishListScreen.routeName: (ctx) => WishListScreen(),
          ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
        },
      ),
    );
  }
}
