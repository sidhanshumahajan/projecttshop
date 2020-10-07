import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ktlabs/models/product.dart';

class ProductService {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<List<Product>> fetchCategoryBasedProducts(String category) async {
    List<Product> loadProducts = [];
    List<dynamic> categories = [];
    Map<String, bool> extractedFavourites =
        await ProductService().fetchUserFavorites();
    await _firestore.collection('products').get().then(
      (document) {
        final response = document.docs;
        for (var i = 0; i < response.length; i++) {
          final data = response[i];
          categories = data.data()['category'];
          if (categories.contains(category)) {
            loadProducts.add(Product(
              id: data.id,
              title: data.data()['title'],
              description: data.data()['description'],
              price: data.data()['price'],
              productPic: data.data()['productPics'],
              category: data.data()['category'] as List<dynamic>,
              brand: data.data()['brand'],
              isFavourite: extractedFavourites.isEmpty
                  ? false
                  : extractedFavourites[data.id] ?? false,
            ));
          }
        }
      },
    );
    return loadProducts;
  }

  Future<Map<String, bool>> fetchUserFavorites() async {
    String id = FirebaseAuth.instance.currentUser.uid;
    Map<String, bool> loadFavorite = {};
    await _firestore.collection('userFavourites').get().then((value) {
      final response = value.docs;
      for (var i = 0; i < response.length; i++) {
        final data = response[i];
        if (data.data()['userId'] == id) {
          loadFavorite.putIfAbsent(
              data.data()['productId'], () => data.data()['isfavorite']);
        }
      }
    });
    return loadFavorite;
  }

  Future<List<Product>> getWhislistProducts(
      Map<String, bool> extractedFavourites) async {
    List<Product> loadFavourite = [];
    await _firestore.collection('products').get().then((value) {
      final response = value.docs;
      for (var i = 0; i < response.length; i++) {
        final data = response[i];
        extractedFavourites.forEach((key, value) {
          if (key == data.id && value == true) {
            loadFavourite.add(Product(
              id: data.id,
              title: data.data()['title'],
              description: data.data()['title'],
              price: data.data()['price'],
              productPic: data.data()['productPics'],
              category: data.data()['category'] as List<dynamic>,
              brand: data.data()['brand'],
            ));
          }
        });
      }
    });
    return loadFavourite;
  }

  Future<List<Product>> searchProducts(String productName) async {
    String searchKey = productName[0].toUpperCase() + productName.substring(1);
    return _firestore
        .collection('products')
        .orderBy('title')
        .startAt([searchKey])
        .endAt([searchKey + '\uf8ff'])
        .get()
        .then((value) {
          List<Product> loadProducts = [];
          final response = value.docs;
          for (var i = 0; i < response.length; i++) {
            final data = response[i];
            loadProducts.add(Product(
              id: data.id,
              title: data.data()['title'],
              description: data.data()['description'],
              price: data.data()['price'],
              productPic: data.data()['productPics'],
              category: data.data()['category'],
              brand: data.data()['brand'],
            ));
          }
          return loadProducts;
        });
  }
}
