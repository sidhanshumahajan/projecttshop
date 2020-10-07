import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ktlabs/features/presentation/providers/cart_provider.dart';
import 'package:ktlabs/features/presentation/providers/gift_provider.dart';
import 'package:ktlabs/features/presentation/providers/product_provider.dart';
import 'package:ktlabs/features/presentation/screens/cart_screen.dart';
import 'package:ktlabs/features/presentation/screens/components/cart_couter.dart';
import 'package:ktlabs/features/presentation/screens/components/product_grid.dart';
import 'package:ktlabs/features/presentation/widgets/badge.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/description';
  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments;
    final loadProduct =
        Provider.of<Products>(context, listen: false).findById(productId);
    final giftProvider = Provider.of<GiftProvider>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);

    return Scaffold(
      appBar: new AppBar(
        title: InkWell(
          onTap: () {
            Navigator.of(context).pushNamed('/');
          },
          child: Text('KT-Labs'),
        ),
        actions: <Widget>[
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
      body: ListView(
        children: <Widget>[
          Container(
            height: 300.0,
            child: GridTile(
              child: Container(
                height: 1200,
                color: Colors.white,
                child: Carousel(
                  boxFit: BoxFit.cover,
                  images: [
                    NetworkImage(loadProduct.productPic[0]),
                    NetworkImage(loadProduct.productPic[1]),
                  ],
                  autoplay: false,
                  dotBgColor: Colors.transparent,
                  animationCurve: Curves.fastOutSlowIn,
                  animationDuration: Duration(milliseconds: 1000),
                ),
              ),
              footer: Container(
                color: Colors.white70,
                child: ListTile(
                  leading: new Text(
                    loadProduct.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  title: new Row(
                    children: <Widget>[
                      Expanded(
                        child: Text('Price \u{20B9} ${loadProduct.price}'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CartCounter(productId, loadProduct.price, loadProduct.title),
          ),
          Row(
            children: [
              Builder(
                builder: (context) {
                  return RaisedButton(
                    color: Colors.blueAccent,
                    elevation: 0.5,
                    textColor: Colors.white,
                    onPressed: () {
                      cart.addItem(
                          loadProduct.id, loadProduct.price, loadProduct.title);
                      Scaffold.of(context).hideCurrentSnackBar();
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              'You have added ${loadProduct.title} into the cart !!'),
                          duration: Duration(seconds: 2),
                          action: SnackBarAction(
                            label: 'UNDO',
                            onPressed: () {
                              cart.reduceProductQunatityOnlyByOne(
                                  loadProduct.id);
                            },
                          ),
                        ),
                      );
                      Navigator.of(context).pushNamed(CartScreen.routeName);
                    },
                    child: new Text('Buy Now'),
                  );
                },
              ),
              Builder(
                builder: (context) {
                  return IconButton(
                    icon: Icon(Icons.shopping_cart),
                    onPressed: () {
                      cart.addItem(
                          loadProduct.id, loadProduct.price, loadProduct.title);
                      Scaffold.of(context).hideCurrentSnackBar();
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              'You have added ${loadProduct.title} into the cart !!'),
                          duration: Duration(seconds: 2),
                          action: SnackBarAction(
                            label: 'UNDO',
                            onPressed: () {
                              cart.reduceProductQunatityOnlyByOne(
                                  loadProduct.id);
                            },
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                RaisedButton(
                  elevation: 4,
                  color: Colors.yellowAccent[700],
                  textColor: Colors.white,
                  child: Text('Add into Gift Registry',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      )),
                  onPressed: () async {
                    final result = await giftProvider.addGifts(
                      productId,
                      loadProduct.title,
                      loadProduct.description,
                      loadProduct.price,
                      loadProduct.brand,
                    );
                    result
                        ? Fluttertoast.showToast(
                            msg: 'Already Available in giftRegistry')
                        : Fluttertoast.showToast(msg: 'Added to giftRegistry');
                  },
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: ListTile(
              title: Text('Product Details'),
              subtitle: Text(loadProduct.description),
            ),
          ),
          Divider(),
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                child: Text(
                  'Product Name:',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(loadProduct.title),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                child: Text(
                  'Product Brand:',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text('${loadProduct.brand}'),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                child: Text(
                  'Product Condition:',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text('new'),
              ),
            ],
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Similar Products',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
          ),
          Container(
            height: 320.0,
            child: SimilarProducts(),
          ),
        ],
      ),
    );
  }
}

class SimilarProducts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProductsGrid();
  }
}
