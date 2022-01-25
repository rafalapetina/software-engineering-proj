import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:health_app/screens/pre_register_screen.dart';
import 'package:health_app/widgets/auth_card.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;

  void _submitAuthForm(String email, String password, bool isLogin, BuildContext ctx) async {
    AuthResult authResult;

    try {
      if (isLogin) {
        authResult = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        print(authResult);
        Navigator.of(ctx).pushReplacementNamed(PreRegister.routeName);
      }
    } on PlatformException catch (err) {
      var message = 'Ocorreu um erro, cheque as suas credenciais';
      if (message != null) {
        message = err.message;
      }
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(ctx).errorColor,
          content: Text(message),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 227, 227, 1),
      body: AuthForm(_submitAuthForm),
    );
  }
}
