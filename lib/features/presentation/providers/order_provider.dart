import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ktlabs/models/cart_item.dart';
import 'package:ktlabs/models/order_item.dart';
import 'package:ktlabs/services/orderService.dart';
import 'package:uuid/uuid.dart';

class Orders with ChangeNotifier {
  String id = FirebaseAuth.instance.currentUser.uid;
  String uuid = Uuid().v1();
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> fetchAndSetOrders() async {
    try {
      List<OrderItem> allOrders = await OrderService().getOrders(id);
      _orders = allOrders;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> addOrder(List<CartItem> cartProducts, double amount) async {
    final timeStamp = DateTime.now();
    try {
      await OrderService()
          .storeOrders(cartProducts, amount, id, uuid, timeStamp);

      final newOrder = OrderItem(
        id: uuid,
        totalAmount: amount,
        products: cartProducts,
        orderDateTime: timeStamp,
      );
      _orders.insert(0, newOrder);
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }
}
