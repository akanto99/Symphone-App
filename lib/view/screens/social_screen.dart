import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:symphone_app/provider/DarkAndLightTheme/theme_provider.dart';
import 'package:symphone_app/responsive/responsive_ui.dart';

class SocialScreen extends StatefulWidget {
  const SocialScreen({super.key});

  @override
  State<SocialScreen> createState() => _SocialScreenState();
}

class _SocialScreenState extends State<SocialScreen> {
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
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
    return Container(
      height: screenHeight ,
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.black : null,
        gradient: isDarkMode
            ? null
            : LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFF1F7FF),
            Color(0xFFF6F6F6),
          ],
        ),
      ),
      child: Center(
        child: Text("Social Screen"),
      ),
    );
  }
}
