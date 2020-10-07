import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ktlabs/models/brands.dart';
import 'package:slugify2/slugify.dart';

class BrandService with ChangeNotifier {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String _collectionName = "brands";
  List<BrandModel> _brands = [];

  List<BrandModel> get brand {
    return [..._brands];
  }

  void createBrand(String brandName) {
    final slug = Slugify(lowercase: true).slugify(brandName);
    _firestore.collection(_collectionName).doc().set(
      {
        "name": brandName,
        "slug": slug,
        "createdAt": DateTime.now().toIso8601String(),
      },
    );
  }

  Future<void> getBrands() {
    _firestore.collection(_collectionName).get().then((value) {
      final response = value.docs;
      final List<BrandModel> loadData = [];
      for (var i = 0; i < response.length; i++) {
        final data = response[i];
        loadData.add(BrandModel(
            id: data.id, name: data.data()['name'], slug: data.data()['slug']));
      }
      _brands = loadData;
      notifyListeners();
    }).catchError((error) {
      throw (error);
    });
  }
}
