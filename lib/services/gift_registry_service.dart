import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ktlabs/models/giftRegistry.dart';
import 'package:uuid/uuid.dart';

class GiftRegistryService {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String ref = "giftRegistry";
  String uuid = Uuid().v1();
  storeGifts(List<GiftRegistry> gifts) async {
    gifts.forEach((element) {
      _firestore.collection(ref).doc(element.userId).set({
        "id": uuid,
        "userId": element.userId,
        "title": element.title,
        "description": element.desc,
        "price": element.price,
        "productId": element.productId
      });
    });
  }

  Future<List<GiftRegistry>> fetchGiftRegisterProducts(String userId) async {
    List<GiftRegistry> loadGifts = [];
    await _firestore.collection(ref).get().then((value) {
      final response = value.docs;
      for (var i = 0; i < response.length; i++) {
        final data = response[i];
        if (data.id == userId) {
          loadGifts.add(
            GiftRegistry(
              userId: data.data()['uuid'],
              productId: data.data()['productId'],
              title: data.data()['title'],
              desc: data.data()['description'],
              price: data.data()['price'],
              brand: data.data()['brand'],
            ),
          );
        }
      }
    });
    return loadGifts;
  }
}
