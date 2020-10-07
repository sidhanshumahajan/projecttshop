import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ktlabs/features/presentation/widgets/auth/auth_form.dart';

class AuthScreen extends StatefulWidget {
  static const routeName = '/login';
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  var _isLoading = false;
  void _submitAuthForm(
    String email,
    String password,
    String username,
    bool isLogin,
    String role,
    BuildContext ctx,
  ) async {
    UserCredential userCredentials;
    try {
      setState(() {
        _isLoading = true;
      });
      if (isLogin) {
        userCredentials = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        userCredentials = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        Fluttertoast.showToast(msg: 'User Sucessfully added');
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredentials.user.uid)
            .set({
          "username": username,
          "email": email,
          "role": role,
        });
      }
    } on PlatformException catch (error) {
      var message = 'No error occure please check your credentials';
      if (error.message != null) {
        message = 'This email address already in use';
      }
      _showErrorDailog(message);
      setState(() {
        _isLoading = false;
      });
    } catch (error) {
      const message = 'Could Authenticate. Please try Again!';
      _showErrorDailog(message);
      setState(() {
        _isLoading = false;
      });
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(
        _submitAuthForm,
        _isLoading,
      ),
    );
  }

  void _showErrorDailog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('An Error Occured!'),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Okay'))
        ],
      ),
    );
  }
}
