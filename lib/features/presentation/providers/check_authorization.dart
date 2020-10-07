import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ktlabs/features/presentation/screens/admin/screens/admin.dart';
import 'package:ktlabs/features/presentation/screens/home_page.dart';

class Authorization {
  Widget checkAuthorization(BuildContext context) {
    final _currentUserId = FirebaseAuth.instance.currentUser.uid;
    Widget value = StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(_currentUserId)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error${snapshot.error}');
        }
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return splashScreen();
          default:
            return checkRole(snapshot.data);
        }
      },
    );
    return value;
  }

  Widget checkRole(DocumentSnapshot snapshot) {
    if (snapshot.data()['role'] == 'admin') {
      return AdminPage();
    } else {
      return Homepage();
    }
  }

  Widget splashScreen() {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
