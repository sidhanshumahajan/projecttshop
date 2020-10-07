import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  AuthForm(this.submitFn, this.isLoading);
  final bool isLoading;
  final void Function(
    String email,
    String password,
    String username,
    bool isLogin,
    String role,
    BuildContext ctx,
  ) submitFn;

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLogin = true;
  String _userEmail = '';
  String _username = '';
  String _userPassword = '';
  String _role = 'user';
  void _submitForm() {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState.validate()) {
      return;
    } else {
      _formKey.currentState.save();
      widget.submitFn(_userEmail.trim(), _userPassword.trim(), _username.trim(),
          _isLogin, _role.trim(), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(20),
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextFormField(
                  key: ValueKey('email'),
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(labelText: 'Email Address'),
                  validator: (value) {
                    if (value.isEmpty || !value.contains('@')) {
                      return 'Please provide a valid email address';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _userEmail = value;
                  },
                ),
                if (!_isLogin)
                  TextFormField(
                    key: ValueKey('username'),
                    decoration: InputDecoration(labelText: 'Username'),
                    validator: (value) {
                      if (value.isEmpty || value.length < 4) {
                        return 'Please eneter atleast 4 character username';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _username = value;
                    },
                  ),
                TextFormField(
                  key: ValueKey('password'),
                  obscureText: true,
                  decoration: InputDecoration(labelText: 'Password'),
                  validator: (value) {
                    if (value.isEmpty || value.length < 7) {
                      return 'Please eneter a password of miniumm 7 characters';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _userPassword = value;
                  },
                ),
                SizedBox(
                  height: 12.0,
                ),
                if (widget.isLoading)
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: CircularProgressIndicator(),
                  ),
                if (!widget.isLoading)
                  RaisedButton(
                    onPressed: _submitForm,
                    child: Text(_isLogin ? 'Login' : 'SignUp'),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    color: Colors.blueAccent,
                    textColor: Colors.white,
                  ),
                if (!widget.isLoading)
                  FlatButton(
                    onPressed: () {
                      setState(() {
                        _isLogin = !_isLogin;
                      });
                    },
                    child: Text(_isLogin
                        ? 'Create an account'
                        : 'I already have an account'),
                    textColor: Colors.black,
                  )
              ],
            ),
          ),
        )),
      ),
    );
  }
}
