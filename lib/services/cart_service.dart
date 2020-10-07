import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ktlabs/models/cart_item.dart';
import 'package:uuid/uuid.dart';

class CartService {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String ref = "cartItemCollection";
  String userId = FirebaseAuth.instance.currentUser.uid;
  String uuid = Uuid().v1();

  addCartItem(Map<String, CartItem> cartItems) {
    cartItems.forEach((key, value) {
      _firestore.collection('cartItemCollection').doc(key).set(
        {
          'userId': userId,
          'cartItem': {
            "cartId": uuid,
            "title": value.title,
            "price": value.price,
            "quantity": value.quantity,
            "createdAt": DateTime.now().toIso8601String(),
            "updateAt": DateTime.now().toIso8601String(),
          },
        },
      );
    });
  }

  Future<Map<String, CartItem>> fetchItems() async {
    Map<String, CartItem> cartItem = {};
    _firestore.collection('cartItemCollection').get().then((value) {
      final response = value.docs;
      for (var i = 0; i < response.length; i++) {
        final data = response[i];
        if (data.data()['userId'] == userId) {
          cartItem.putIfAbsent(
            data.id,
            () => CartItem(
              id: data.data()['cartId'],
              title: data.data()['title'],
              price: data.data()['price'],
              quantity: data.data()['quantity'],
            ),
          );
        }
      }
    });
    
  }

  removeItem(String id) {
    _firestore.collection('cartItemCollection').doc(id).delete();
  }
}
