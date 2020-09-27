import 'package:flutter/material.dart';
import 'package:ktlabs/models/cart_item.dart';
import 'package:ktlabs/models/order_item.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Orders with ChangeNotifier {
  final String userId = '';
  final String token = '';
  List<OrderItem> _orders = [];

  //Orders(this.token, this.userId, this._orders);

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> fetchAndSetOrders() async {
    // final url = '';
    // try {
    //   final response = await http.get(url);
    //   final responseExtractedData =
    //       json.decode(response.body) as Map<String, dynamic>;
    //   final List<OrderItem> loadOrders =
    //       []; // created to store reference of orignal data
    //   if (responseExtractedData != null) {
    //     responseExtractedData.forEach(
    //       (orderID, orderData) {
    //         loadOrders.add(
    //           OrderItem(
    //             id: orderID,
    //             totalAmount: orderData['totalAmount'],
    //             orderDateTime: DateTime.parse(orderData['orderDateTime']),
    //             products: (orderData['products'] as List<dynamic>)
    //                 .map(
    //                   (item) => CartItem(
    //                     id: item['id'],
    //                     title: item['title'],
    //                     price: item['price'],
    //                     quantity: item['quantity'],
    //                   ),
    //                 )
    //                 .toList(),
    //           ),
    //         );
    //       },
    //     );
    //     _orders = loadOrders.reversed.toList();
    //     notifyListeners();
    //   } else {
    //     _orders = [];
    //   }
    // } catch (error) {
    //   throw (error);
    // }
    print('orders');
  }

  Future<void> addOrders(List<CartItem> cartProducts, double amount) async {
    final url = '';
    final timeStamp = DateTime.now();
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'totalAmount': amount,
            'orderDateTime': timeStamp,
            'products': cartProducts.map((cp) => CartItem(
                  id: cp.id,
                  title: cp.title,
                  price: cp.price,
                  quantity: cp.quantity,
                )),
          },
        ),
      );
      _orders.insert(
        0,
        OrderItem(
          id: json.decode(response.body)['name'],
          totalAmount: amount,
          products: cartProducts,
          orderDateTime: timeStamp,
        ),
      );
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }
}
