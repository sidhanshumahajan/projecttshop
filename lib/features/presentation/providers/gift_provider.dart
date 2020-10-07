import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:ktlabs/models/giftRegistry.dart';
import 'package:ktlabs/services/gift_registry_service.dart';

class GiftProvider with ChangeNotifier {
  Map<String, GiftRegistry> _gifts = {};
  List<GiftRegistry> _items = [];
  bool result = false;
  Map<String, GiftRegistry> get gift {
    return {..._gifts};
  }

  List<GiftRegistry> get items {
    return [..._items];
  }

  Future<bool> addGifts(
    String productId,
    String title,
    String desc,
    double price,
    String brand,
  ) async {
    String userId = FirebaseAuth.instance.currentUser.uid;
    if (_gifts.containsKey(productId)) {
      return result = true;
    } else {
      _gifts.putIfAbsent(
        productId,
        () => GiftRegistry(
            productId: productId,
            title: title,
            price: price,
            desc: desc,
            brand: brand),
      );
      _gifts.forEach((key, value) {
        _items.add(GiftRegistry(
          userId: userId,
          title: value.title,
          price: value.price,
          desc: value.desc,
          brand: value.brand,
          productId: value.productId,
        ));
      });
      GiftRegistryService().storeGifts(_items);
      return result = false;
    }
  }

  Future<void> fetchGifts() async {
    try {
      List<GiftRegistry> loadGifts = [];
      String userId = FirebaseAuth.instance.currentUser.uid;
      loadGifts = await GiftRegistryService().fetchGiftRegisterProducts(userId);
      _items = loadGifts;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  void clearAllGifts() {
    _items = [];
    notifyListeners();
  }
}
