import 'package:flutter/material.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final double price;
  final List<String> productPic;
  final String description;
  final String category;
  bool isFavourite;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.productPic,
    @required this.category,
    this.isFavourite = false,
  });
}
