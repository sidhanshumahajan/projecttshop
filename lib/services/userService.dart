import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ktlabs/models/user_model.dart';

class UserService {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String ref = "users";
  Future<UserModel> getUserById(String id) {
    _firestore.collection(ref).doc(id).get().then((document) {
      return UserModel(
        id: id,
        email: document.data()['email'],
        username: document.data()['username'],
      );
    });
  }
}
