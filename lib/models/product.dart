import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final double price;
  final List<dynamic> productPic;
  final String description;
  final List<dynamic> category;
  final String brand;
  bool isFavourite;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.productPic,
    @required this.category,
    @required this.brand,
    this.isFavourite = false,
  });
  void _setValueStatus(bool newValue) {
    isFavourite = newValue;
    notifyListeners();
  }

  void toggleFavourite(String pid) {
    final oldStatus = isFavourite;
    isFavourite = !isFavourite;
    notifyListeners();
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    String uid = FirebaseAuth.instance.currentUser.uid;
    try {
      _firestore.collection('userFavourites').doc(pid).set({
        'userId': uid,
        'productId': pid,
        'isfavorite': isFavourite,
      });
    } catch (error) {
      _setValueStatus(oldStatus);
    }
  }
}
