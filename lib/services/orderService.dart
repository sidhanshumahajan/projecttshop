import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ktlabs/models/cart_item.dart';
import 'package:ktlabs/models/order_item.dart';

class OrderService {
  String ref = "orders";
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> storeOrders(List<CartItem> cartProduct, double amount,
      String userId, String uuid, timeStamp) async {
    await _firestore.collection(ref).doc().set({
      'userId': userId,
      'totalAmount': amount,
      'orderDateTime': timeStamp.toIso8601String(),
      'products': cartProduct
          .map((cp) => {
                "id": uuid,
                "title": cp.title,
                "price": cp.price,
                "quantity": cp.quantity,
              })
          .toList(),
    });
  }

  Future<List<OrderItem>> getOrders(String id) async {
    List<OrderItem> loadOrders = [];
    await _firestore.collection(ref).get().then((value) {
      final response = value.docs;
      for (var i = 0; i < response.length; i++) {
        final order = response[i];
        if (order.data()['userId'] == id) {
          loadOrders.add(OrderItem(
            id: order.id,
            totalAmount: order.data()['totalAmount'],
            products: (order.data()['products'] as List<dynamic>)
                .map((item) => CartItem(
                      id: item['id'],
                      title: item['title'],
                      price: item['price'],
                      quantity: item['quantity'],
                    ))
                .toList(),
            orderDateTime: DateTime.parse(order.data()['orderDateTime']),
          ));
        } else {
          loadOrders = [];
        }
      }
    });
    return loadOrders.reversed.toList();
  }
}
