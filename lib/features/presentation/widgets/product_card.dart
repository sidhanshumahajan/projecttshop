import 'package:flutter/material.dart';
import 'package:ktlabs/models/product.dart';
import 'package:ktlabs/features/presentation/screens/product_detail_screen.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class ProductCard extends StatefulWidget {
  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          ProductDetailScreen.routeName,
          arguments: product.id,
        );
      },
      child: Container(
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
                  Positioned.fill(
                      child: Align(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(),
                  )),
                  Center(
                    child: FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      image: product.productPic[0],
                      height: 140,
                      width: 120,
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              ),
            ),
            Column(children: [
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Text(
                  '${product.title}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, top: 4.0),
                child: Text(
                  'By${product.brand}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 10.0,
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Text(
                  '\u{20B9}${product.price}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
              ),
            ])
          ],
        ),
      ),
    );
  }
}
