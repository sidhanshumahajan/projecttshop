import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:ktlabs/features/data/mockdata.dart';
import 'package:ktlabs/models/product.dart';
import 'package:ktlabs/services/productService.dart';
import 'dart:io' show Platform;

class Products with ChangeNotifier {
  List<String> _urls = [];
  List<Product> _productItems = [];
  List<Product> _categoryBaseProducts = [];
  List<Product> _gifts = [];
  List<Product> _favouriteProducts = [];
  List<Product> _searchProducts = [];
  List<Product> get items {
    return [..._productItems];
  }

  List<Product> get searchedProducts {
    return [..._searchProducts];
  }

  List<Product> get favouriteProducts {
    return [..._favouriteProducts];
  }

  List<Product> get categoryBaseProducts {
    return [..._categoryBaseProducts];
  }

  List<Product> get gift {
    return [..._gifts];
  }

  List<String> get url {
    return [..._urls];
  }

  Product findById(productId) {
    fetchAndSetProducts();
    return _productItems.firstWhere((element) => element.id == productId);
  }

  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<void> fetchAndSetProducts() async {
    if (Platform.isWindows) {
      _productItems = MockRepository().mockProductItems;
      notifyListeners();
    } else {
      Map<String, bool> extractedFavourites =
          await ProductService().fetchUserFavorites();
      await _firestore.collection('products').get().then((value) {
        final response = value.docs;
        final List<Product> loadProducts = [];
        for (var i = 0; i < response.length; i++) {
          final data = response[i];
          loadProducts.add(Product(
            id: data.id,
            title: data.data()['title'],
            description: data.data()['title'],
            price: data.data()['price'],
            productPic: data.data()['productPics'],
            category: data.data()['category'] as List<dynamic>,
            brand: data.data()['brand'],
            isFavourite: extractedFavourites.isEmpty
                ? false
                : extractedFavourites[data.id] ?? false,
          ));
          _productItems = loadProducts;
          notifyListeners();
        }
      }).catchError((error) {
        throw (error);
      });
    }
  }

  Future<void> uploadImageAndGetUrls(List paths) async {
    _urls = [];
    String imageUrl1;
    String imageUrl2;
    String imageUrl3;
    final FirebaseStorage str = FirebaseStorage.instance;
    final imageName1 = "1${DateTime.now().toIso8601String().toString()}.jpg";
    StorageUploadTask task1 = str.ref().child(imageName1).putFile(paths[0]);
    final imageName2 = "2${DateTime.now().toIso8601String().toString()}.jpg";
    StorageUploadTask task2 = str.ref().child(imageName2).putFile(paths[1]);
    final imageName3 = "3${DateTime.now().toIso8601String().toString()}.jpg";
    StorageUploadTask task3 = str.ref().child(imageName3).putFile(paths[2]);
    StorageTaskSnapshot snapshot1 =
        await task1.onComplete.then((snap1) => snap1);
    StorageTaskSnapshot snapshot2 =
        await task2.onComplete.then((snap2) => snap2);

    task3.onComplete.then((snapshot3) async {
      imageUrl1 = await snapshot1.ref.getDownloadURL();
      imageUrl2 = await snapshot2.ref.getDownloadURL();
      imageUrl3 = await snapshot3.ref.getDownloadURL();
      _urls.add(imageUrl1);
      _urls.add(imageUrl2);
      _urls.add(imageUrl3);
      notifyListeners();
    }).catchError((error) {
      throw (error);
    });
  }

  Future<void> uploadProduct({
    String title,
    String desc,
    List<String> categories,
    String brand,
    List<String> pics,
    double price,
  }) {
    try {
      _firestore.collection('products').doc().set(
        {
          'title': title,
          'description': desc,
          'price': price,
          'productPics': pics,
          'category': categories,
          'brand': brand,
          'isFavorite': false,
          "createdAt": DateTime.now().toIso8601String(),
        },
      );
      final newProduct = Product(
        id: '${DateTime.now()}',
        title: title,
        description: desc,
        price: price,
        productPic: url,
        category: categories,
        brand: brand,
      );
      _productItems.insert(0, newProduct);
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> fetchProducts(String category) async {
    try {
      _categoryBaseProducts = await ProductService()
          .fetchCategoryBasedProducts(category.toLowerCase());
      notifyListeners();
    } catch (error) {
      throw (error);
    }
    notifyListeners();
  }

  Future<void> fetchWhislistProductOnly() async {
    Map<String, bool> extractedFavourites =
        await ProductService().fetchUserFavorites();
    _favouriteProducts =
        await ProductService().getWhislistProducts(extractedFavourites);
    notifyListeners();
  }

  int get totalNoOfwhislistItem {
    return _favouriteProducts.length;
  }

  void removeItemFromWhisList(String productId) {
    Product pro;
    _favouriteProducts.forEach((element) {
      if (element.id == productId) {
        pro = element;
      }
    });
    if (pro != null) {
      _favouriteProducts.remove(pro);
    }
    notifyListeners();
  }

  Future<void> productSearch(String productName) async {
    _searchProducts = await ProductService().searchProducts(productName);
    notifyListeners();
  }
}
