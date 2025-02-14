import 'package:flutter/material.dart';
import 'package:symphone_app/responsive/responsive_ui.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: ResPonsiveUi(
            mobile: body(),
            desktop: body(),
            tablet: body(),
          )),
    );
  }

  Widget body() {
    final screenHeight = MediaQuery.of(context).size.height * 1;
    final screenWidth = MediaQuery.of(context).size.width * 1;
    return Center(
      child: Text("Home Screen"),
    );
  }
}
