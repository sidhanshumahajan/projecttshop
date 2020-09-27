import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CatalogueModel {
  String id;
  String parentCategories;

  CatalogueModel({
    @required this.id,
    @required this.parentCategories,
  });
}

class Catelogue with ChangeNotifier {
  List<CatalogueModel> _items = [];

  List<CatalogueModel> get items {
    return [..._items];
  }

  Future<void> addCatalogue([String parentCategory = 'sports']) async {
    final url = 'https://ktlabs-shop.firebaseio.com/catalogue.json';
    final response = await http.post(
      url,
      body: json.encode(parentCategory),
    );
    final newCatalogue = CatalogueModel(
      id: json.decode(response.body)['name'],
      parentCategories: parentCategory,
    );
    _items.insert(0, newCatalogue);
    notifyListeners();
  }

  Future<void> fetchAndSetCatalogue(
      [String parentCategory = 'electronics']) async {
    final url = 'https://ktlabs-shop.firebaseio.com/catalogue.json';
    final response = await http.get(url);
    final extractData = json.decode(response.body) as Map<String, dynamic>;
    List<CatalogueModel> loadCatalogue = [];
    extractData.forEach(
      (key, value) {
        loadCatalogue.add(
          CatalogueModel(
            id: value,
            parentCategories: extractData[key],
          ),
        );
      },
    );
    _items = loadCatalogue;
    notifyListeners();
  }
}
