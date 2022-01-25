import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 227, 227, 1),
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
