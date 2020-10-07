import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ktlabs/features/presentation/screens/product_list.dart';

class HorizontalListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Category(
            imageLoaction:
                'https://firebasestorage.googleapis.com/v0/b/ktlabs-9aed7.appspot.com/o/electronics.png?alt=media&token=19861dc5-a4c0-47b4-9827-1ea1f1f68131',
            imageCaption: 'Electronics',
          ),
          Category(
            imageLoaction:
                'https://firebasestorage.googleapis.com/v0/b/ktlabs-9aed7.appspot.com/o/formal.png?alt=media&token=b1ad9a0f-6c9c-4b32-bca1-4e0483eb8474',
            imageCaption: 'Men',
          ),
          Category(
            imageLoaction:
                'https://firebasestorage.googleapis.com/v0/b/ktlabs-9aed7.appspot.com/o/shoe.jpg?alt=media&token=8499a0fc-f45c-45d8-bb95-48ec816ee65d',
            imageCaption: 'Shoes',
          ),
          Category(
            imageLoaction:
                'https://firebasestorage.googleapis.com/v0/b/ktlabs-9aed7.appspot.com/o/dress.png?alt=media&token=c55ceded-4e45-4378-88e9-20cf52edb0cf',
            imageCaption: 'Women',
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
            title: Image.network(
              imageLoaction,
              width: 90.0,
              height: 50.0,
            ),
            subtitle: Container(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 3.0),
                child: Text(
                  imageCaption,
                  style: TextStyle(
                    fontSize: 9.0,
                  ),
                ),
              ),
            ),
          ),
        ),
        onTap: () {
          Navigator.of(context)
              .pushNamed(ProductListPage.routeName, arguments: imageCaption);
        },
      ),
    );
  }
}
