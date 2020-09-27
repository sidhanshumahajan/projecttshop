import 'package:flutter/material.dart';
import 'package:ktlabs/models/http_exception.dart';
import 'package:ktlabs/models/product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Products with ChangeNotifier {
  final String userId = '';
  final String token = '';
  List<Product> _productItems = [
    Product(
      id: 'p1',
      title: 'Shirt',
      description:
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry  Lorem Ipsum has been the industry' +
              'standard dummy text ever since the 1500swhen an unknown printer took a galley of type and scrambled it to make a' +
              'type specimen book.It has survived not only five centuries but also the leap into electronic typesetting ',
      productPic: [
        'products/white_shirt1.jpeg',
        'products/white_shirt2.jpeg',
        'products/white_shirt3.jpeg',
        'products/white_shirt4.jpeg',
      ],
      price: 300,
      category: 'shirt',
    ),
    Product(
      id: 'p2',
      title: 'Blazor',
      description:
          ' Lorem Ipsum is simply dummy text of the printing and typesetting industry  Lorem Ipsum has been the industry' +
              'standard dummy text ever since the 1500swhen an unknown printer took a galley of type and scrambled it to make a' +
              'type specimen book.It has survived not only five centuries but also the leap into electronic typesetting ',
      productPic: [
        'products/blazer1.jpeg',
      ],
      price: 20000,
      category: 'formal',
    ),
    Product(
      id: 'p3',
      title: 'Trouser',
      description:
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry  Lorem Ipsum has been the industry' +
              'standard dummy text ever since the 1500swhen an unknown printer took a galley of type and scrambled it to make a' +
              'type specimen book.It has survived not only five centuries but also the leap into electronic typesetting ',
      productPic: [
        'products/pants2.jpeg',
      ],
      price: 700,
      category: 'Jeans',
    ),
    Product(
      id: 'p4',
      title: 'Trouser',
      description:
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry  Lorem Ipsum has been the industry' +
              'standard dummy text ever since the 1500swhen an unknown printer took a galley of type and scrambled it to make a' +
              'type specimen book.It has survived not only five centuries but also the leap into electronic typesetting ',
      productPic: [
        'products/skt1.jpeg',
      ],
      price: 700,
      category: 'Jeans',
    ),
    Product(
      id: 'p5',
      title: 'Trouser',
      description:
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry  Lorem Ipsum has been the industry' +
              'standard dummy text ever since the 1500swhen an unknown printer took a galley of type and scrambled it to make a' +
              'type specimen book.It has survived not only five centuries but also the leap into electronic typesetting ',
      productPic: [
        'products/dress2.jpeg',
      ],
      price: 700,
      category: 'Jeans',
    ),
    Product(
      id: 'P6',
      title: 'Trouser',
      description:
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry  Lorem Ipsum has been the industry' +
              'standard dummy text ever since the 1500swhen an unknown printer took a galley of type and scrambled it to make a' +
              'type specimen book.It has survived not only five centuries but also the leap into electronic typesetting ',
      productPic: [
        'products/blazer2.jpeg',
      ],
      price: 700,
      category: 'Jeans',
    ),
  ];
  // Products(this.token, this.userId, this._productItems);

  List<Product> get items {
    return [..._productItems];
  }

  Product findById(productId) {
    return _productItems.firstWhere((element) => element.id == productId);
  }

  Future<void> addProduct(Product product) async {
    final url = '';
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'price': product.price,
          'productPic': product.productPic,
          'creatorId': userId,
        }),
      );
      final newProduct = Product(
        id: json.decode(response.body)['name'],
        title: product.title,
        description: product.description,
        productPic: product.productPic,
        price: product.price,
        category: product.category,
      );
      _productItems.insert(0, newProduct);
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> fetchAndSetProducts() async {
    var url = '';
    try {
      final response = await http.get(url);
      final extractedResponseData =
          json.decode(response.body) as Map<String, dynamic>;
      final List<Product> loadProducts = [];
      if (extractedResponseData != null) {
        extractedResponseData.forEach((prodId, prodData) {
          loadProducts.add(Product(
            id: prodId,
            title: prodData['title'],
            description: prodData['description'],
            price: double.tryParse(prodData['price']?.toString()),
            productPic: prodData['productPic'] as List<dynamic>,
            category: prodData['category'],
          ));
        });
        _productItems = loadProducts;
      } else {
        _productItems = [];
      }
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> updateProduct(String productId, Product newProduct) async {
    final index =
        _productItems.indexWhere((product) => product.id == productId);
    if (index >= 0) {
      try {
        final url = '';
        await http.patch(
          url,
          body: json.encode({
            'title': newProduct.title,
            'description': newProduct.description,
            'price': newProduct.price,
            'productPic': newProduct.productPic,
          }),
        );
        _productItems[index] = newProduct;
        notifyListeners();
      } catch (error) {
        throw (error);
      }
    } else {
      print('...');
    }
    notifyListeners();
  }

  Future<void> deleteProduct(productId) async {
    //optimistic deletion
    final url = '';
    final existingProductIndex =
        _productItems.indexWhere((product) => product.id == productId);
    var existingProduct = _productItems[existingProductIndex];
    _productItems.removeAt(existingProductIndex);
    notifyListeners();
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      // rollback deleted product
      _productItems.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw HttpException('Could Not delete product');
    }
    existingProduct = null;
  }
}
