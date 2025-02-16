import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:symphone_app/provider/DarkAndLightTheme/theme_provider.dart';
import 'package:symphone_app/res/color.dart';
import 'package:symphone_app/responsive/responsive_ui.dart';

import '../../utils/routes/routes_name.dart';

class CardScreen extends StatefulWidget {
  const CardScreen({super.key});

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
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
      child: Column(
        children: [
          SizedBox(height: screenHeight*0.02,),

          Container(
            width: screenWidth * 0.90,
            child: Row(
              children: [
                InkWell(
                    onTap:(){
                      Navigator.pop(context);
                    },
                    child: Container(
                        width: screenWidth*0.08,
                        color: Colors.transparent,
                        alignment: Alignment.centerLeft,
                        child: Icon(Icons.arrow_back_ios, color: Colors.red,))),
                // SizedBox(width: screenWidth*0.02,),
                Text("Check Support",
                    style: GoogleFonts.urbanist(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: themeProvider.isDarkMode ? AppColors.whiteColor: AppColors.blackColor,
                      letterSpacing: 0.8,
                    )
                )
              ],
            ),
          ),
          SizedBox(height: screenHeight*0.02,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              boxContainer(isDarkMode ?'assets/images/home_icons/dark/support.png' : 'assets/images/home_icons/light/cal.png', 'Hotline'),
              boxContainer(isDarkMode ?'assets/images/home_icons/dark/power.png' : 'assets/images/home_icons/light/service.png', 'Service Center'),
            ],
          ),
          SizedBox(height: screenHeight*0.02,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context, RoutesName.lsoScreen);
                  },
                  child: boxContainer(isDarkMode ?'assets/images/home_icons/dark/law.png' :'assets/images/home_icons/light/law.png', 'LSO Query')),
              boxContainer(isDarkMode ?'assets/images/home_icons/dark/comment.png' :'assets/images/home_icons/light/review.png', 'Feedback'),
            ],
          ),
          SizedBox(height: screenHeight*0.02,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context, RoutesName.specificationScreen);
                  },
                  child: boxContainer(isDarkMode ?'assets/images/home_icons/dark/profile.png' :'assets/images/home_icons/light/clipboard.png', 'Specification')),
              boxContainer(isDarkMode ?'assets/images/home_icons/dark/apoint.png' :'assets/images/home_icons/light/booking.png', 'Book An\nAppointment'),
            ],
          ),
        ],
      ),
    );
  }

  Widget boxContainer(String image, String text) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Container(
      height: screenHeight * 0.18,
      width: screenWidth * 0.45,
      decoration: BoxDecoration(
        color: themeProvider.isDarkMode ? AppColors.blackOpColor: AppColors.whiteColor,
        border: Border.all(width: 1, color:themeProvider.isDarkMode ? AppColors.blackOpColor:  AppColors.borderColor),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(image, height: 40, width: 40, fit: BoxFit.cover),
            SizedBox(height: 8),
            Text(
              text,
              style: GoogleFonts.urbanist(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: themeProvider.isDarkMode ? AppColors.whiteColor: AppColors.blackColor,
                letterSpacing: 0.8,
              ),),
          ],
        ),
      ),
    );
  }
}
