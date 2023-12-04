// custom_splash.dart
import 'package:flutter/material.dart';

class CustomSplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue, // Set your desired background color
      body: Center(
        child: Text(
          'Your App Name',
          style: TextStyle(
            fontSize: 24.0,
            color: Colors.white, // Set your desired text color
          ),
        ),
      ),
    );
  }
}