import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:symphone_app/provider/DarkAndLightTheme/theme_provider.dart';
import 'package:symphone_app/res/color.dart';
import 'package:symphone_app/responsive/responsive_ui.dart';
import 'package:symphone_app/view/navigation_bar.dart';
import 'package:symphone_app/view/sub_screens/hotline.dart';

import '../../utils/routes/routes_name.dart';

class CardScreen extends StatefulWidget {
  const CardScreen({super.key});

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  int _currentIndex = 1;
  final List<String> _labels = ['Website', 'Home', 'Social'];
  final List<String> _svgPaths = [
    'assets/images/navImages/web.svg',
    'assets/images/navImages/home.svg',
    'assets/images/navImages/social.svg',
  ];

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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
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
                   GestureDetector(
                       onTap: (){
                         Navigator.push(context, MaterialPageRoute(builder: (context)=>HotLine()));
                       },
                       child: boxContainer(isDarkMode ?'assets/images/home_icons/dark/support.png' : 'assets/images/home_icons/light/cal.png', 'Hotline')),
                   GestureDetector(
                       onTap: (){
                         Navigator.pushNamed(context, RoutesName.serviceScreen);
                       },
                       child: boxContainer(isDarkMode ?'assets/images/home_icons/dark/power.png' : 'assets/images/home_icons/light/service.png', 'Service Center')),
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
          ),


          Container(
            color: isDarkMode ? AppColors.blackColor : AppColors.whiteColor,
            child: Container(
              height: screenHeight * 0.09,
              decoration: BoxDecoration(
                color: isDarkMode ? Color(0xff181818) : AppColors.whiteColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35),
                  topRight: Radius.circular(35),
                ),
                boxShadow: [
                  BoxShadow(
                    color: isDarkMode ? AppColors.blackColor : Colors.black.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: Offset(0, -2),
                  ),
                ],
                border: Border(
                  top: BorderSide(width: 2, color: isDarkMode ? AppColors.blackOpColor : AppColors.borderColor),
                  left: BorderSide(width: 2, color: isDarkMode ? AppColors.blackOpColor : AppColors.borderColor),
                  right: BorderSide(width: 2, color: isDarkMode ? AppColors.blackOpColor : AppColors.borderColor),
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(_labels.length, (index) {
                  bool isSelected = _currentIndex == index;
                  return InkWell(
                    onTap: () async {
                      setState(() {
                        _currentIndex = index;
                      });
                      await Future.delayed(Duration(milliseconds: 300));
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NavigationScreen(initialIndex: index),
                        ),
                      );
                      print(index);
                      setState(() {
                        _currentIndex = -1;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: screenWidth * 0.14,
                            child: SvgPicture.asset(
                              _svgPaths[index],
                              height: 24,
                              width: 24,
                              colorFilter: ColorFilter.mode(
                                isSelected ? AppColors.redColor : (isDarkMode ? AppColors.whiteColor : Colors.black),
                                // AppColors.greyColor,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            _labels[index],
                            style: TextStyle(
                              color: isSelected ? AppColors.redColor : (isDarkMode ? AppColors.whiteColor : Colors.black), // Adjust text color based on mode
                              fontSize: isSelected ? 14 : 12,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget boxContainer(String image, String text) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Container(
      height: screenHeight * 0.165,
      width: screenWidth * 0.45,
      decoration: BoxDecoration(
        color: themeProvider.isDarkMode ? AppColors.blackOpColor: AppColors.whiteColor,
        border: Border.all(width: 1, color:themeProvider.isDarkMode ? AppColors.blackOpColor:  AppColors.borderColor),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding:  EdgeInsets.all( screenWidth * 0.04),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                height: screenHeight*0.04, width:40,
                // color: Colors.white,
                child: Image.asset(image, fit: BoxFit.contain, )),
            AutoSizeText(
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
