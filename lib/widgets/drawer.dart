import 'package:flutter/material.dart';
import 'package:ktlabs/screens/all_categories.dart';
import 'package:ktlabs/screens/order_screen.dart';
import 'package:ktlabs/screens/wishlist_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: new ListView(
        children: <Widget>[
          new UserAccountsDrawerHeader(
            accountName: new CircleAvatar(
              child: Text('S'),
            ),
            accountEmail: Text('test@test.com'),
          ),
          ListTile(
            leading: Icon(Icons.dashboard),
            title: new Text('All Categories'),
            onTap: () {
              Navigator.of(context).pushNamed(AllCategories.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.shop),
            title: new Text('Home'),
            onTap: () {
              Navigator.of(context).pushNamed('/');
            },
          ),
          ListTile(
            leading: Icon(Icons.payment),
            title: new Text('My Orders'),
            onTap: () {
              Navigator.of(context).pushNamed(OrderScreen.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.shopping_cart),
            title: new Text('Shoping Cart'),
            onTap: () {
              // Navigator.of(context).pushNamed(WishListScreen.);
            },
          ),
          ListTile(
            leading: Icon(Icons.favorite),
            title: new Text('My Wishlist'),
            onTap: () {
              Navigator.of(context).pushNamed(WishListScreen.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: new Text('Logout'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
