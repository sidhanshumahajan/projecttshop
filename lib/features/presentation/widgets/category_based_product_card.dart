import 'package:flutter/material.dart';
import 'package:ktlabs/models/product.dart';
import 'package:ktlabs/features/presentation/providers/cart_provider.dart';
import 'package:ktlabs/features/presentation/screens/product_detail_screen.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class CategoryBasedProductCard extends StatefulWidget {
  @override
  _CategoryBasedProductCardState createState() =>
      _CategoryBasedProductCardState();
}

class _CategoryBasedProductCardState extends State<CategoryBasedProductCard> {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);
    final cart = Provider.of<Cart>(context, listen: false);

    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          ProductDetailScreen.routeName,
          arguments: product.id,
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 155,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 4,
                offset: Offset(-2, -1),
                color: Colors.grey,
              ),
            ],
          ),
          child: Row(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(11),
                child: Stack(
                  children: <Widget>[
                    Center(child: CircularProgressIndicator()),
                    Center(
                      child: FadeInImage.memoryNetwork(
                        placeholder: kTransparentImage,
                        image: product.productPic[0],
                        height: 100,
                        width: 120,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 6, right: 14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, top: 24.0),
                      child: Text(
                        '${product.title}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 7.0,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 15.0,
                      ),
                      child: Text(
                        'By${product.brand}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 10.0,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 15.0, top: 1, bottom: 2),
                      child: Text(
                        '\u{20B9}${product.price}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: RaisedButton(
                        elevation: 3,
                        color: Colors.orange[600],
                        child: Text('Add To Cart'),
                        onPressed: () {
                          cart.addItem(
                              product.id, product.price, product.title);
                          Scaffold.of(context).hideCurrentSnackBar();
                          Scaffold.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  'You have added ${product.title} into the cart !!'),
                              duration: Duration(seconds: 2),
                              action: SnackBarAction(
                                label: 'UNDO',
                                onPressed: () {
                                  cart.reduceProductQunatityOnlyByOne(
                                      product.id);
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        icon: Icon(product.isFavourite
                            ? Icons.favorite
                            : Icons.favorite_border),
                        color: Theme.of(context).accentColor,
                        onPressed: () {
                          product.toggleFavourite(product.id);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
