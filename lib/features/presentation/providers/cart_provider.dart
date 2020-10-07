import 'package:flutter/material.dart';
import 'package:ktlabs/models/cart_item.dart';
import 'package:ktlabs/services/cart_service.dart';

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmountOfCartItems {
    var totalAmount = 0.0;
    _items.forEach((key, cartItem) {
      totalAmount += cartItem.price * cartItem.quantity;
    });
    return totalAmount;
  }

  void addItem(String productId, double price, String title) {
    if (_items.containsKey(productId)) {
      _items.update(
        productId,
        (existingCartItem) => CartItem(
          id: DateTime.now().toString(),
          title: title,
          price: price,
          quantity: existingCartItem.quantity + 1,
        ),
      );
      CartService().addCartItem(_items);
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItem(
            id: DateTime.now().toString(),
            title: title,
            price: price,
            quantity: 1),
      );
      CartService().addCartItem(_items);
    }
    notifyListeners();
  }

  void reduceProductQunatityOnlyByOne(productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId].quantity > 1) {
      _items.update(
          productId,
          (existingCartItem) => CartItem(
                id: existingCartItem.id,
                price: existingCartItem.price,
                title: existingCartItem.title,
                quantity: existingCartItem.quantity >= 1
                    ? existingCartItem.quantity - 1
                    : 0,
              ));
      CartService().addCartItem(_items);
    } else {
      _items.remove(productId);
      CartService().addCartItem(_items);
    }
    notifyListeners();
  }

  int getQuantity(productId) {
    var defaultQuantity = 1;
    _items.forEach((key, value) {
      if (key == productId) {
        defaultQuantity = value.quantity;
      }
    });
    return defaultQuantity != 0 ? defaultQuantity : defaultQuantity;
  }

  void removeItem(String productId) {
    _items.remove(productId);
    CartService().removeItem(productId);
    notifyListeners();
  }

  void clearCart() {
    _items = {};
    notifyListeners();
  }

  // Future getAllCartItems() async {
  //   final response = await CartService().fetchItems();
  //   _items = response;
  //   notifyListeners();
  // }
}
