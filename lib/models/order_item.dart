import 'package:flutter/cupertino.dart';
import 'package:ktlabs/models/cart_item.dart';

class OrderItem {
  final String id;
  final double totalAmount;
  final List<CartItem> products;
  final DateTime orderDateTime;

  OrderItem({
    @required this.id,
    @required this.totalAmount,
    @required this.products,
    @required this.orderDateTime,
  });
}
