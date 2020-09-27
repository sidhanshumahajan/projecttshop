import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HorizontalListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Category(
            imageLoaction: 'icons/formal.png',
            imageCaption: 'Formals',
          ),
          Category(
            imageLoaction: 'icons/informal.png',
            imageCaption: 'Informal',
          ),
          Category(
            imageLoaction: 'icons/shoe.jpg',
            imageCaption: 'Shoes',
          ),
          Category(
            imageLoaction: 'icons/dress.png',
            imageCaption: 'Dress',
          ),
          Category(
            imageLoaction: 'icons/accessories.jpg',
            imageCaption: 'Accessories',
          ),
          Category(
            imageLoaction: 'icons/jeans.png',
            imageCaption: 'Jeans',
          ),
          Category(
            imageLoaction: 'icons/tshirt.png',
            imageCaption: 'T-Shirt',
          ),
        ],
      ),
    );
  }
}

class Category extends StatelessWidget {
  final String imageLoaction;
  final String imageCaption;

  Category({
    this.imageLoaction,
    this.imageCaption,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: InkWell(
        child: Container(
          width: 80.0,
          child: ListTile(
            title: Image.asset(
              imageLoaction,
              width: 80.0,
              height: 50.0,
            ),
            subtitle: Container(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 3.0),
                child: Text(
                  imageCaption,
                  style: TextStyle(
                    fontSize: 12.0,
                  ),
                ),
              ),
            ),
          ),
        ),
        onTap: () {},
      ),
    );
  }
}
