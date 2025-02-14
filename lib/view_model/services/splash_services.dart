import 'package:flutter/material.dart';
import 'package:symphone_app/view/navigation_bar.dart';

class SplashService {
  Future<void> navigateAfterDelay(BuildContext context) async {
    await Future.delayed(Duration(seconds: 3));
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => NavigationScreen()),
    );
  }
}
