import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:symphone_app/provider/DarkAndLightTheme/theme_provider.dart';
import 'package:symphone_app/res/color.dart';
import 'package:symphone_app/responsive/responsive_ui.dart';
import 'package:symphone_app/view/navigation_bar.dart';

class SpecificationScreen extends StatefulWidget {
  const SpecificationScreen({super.key});

  @override
  State<SpecificationScreen> createState() => _SpecificationScreenState();
}

class _SpecificationScreenState extends State<SpecificationScreen> {
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
      height: screenHeight,
      decoration: BoxDecoration(
        color: isDarkMode ? AppColors.blackColor : null,
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
          Expanded(
            child:SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  Container(
                    width: screenWidth * 0.90,
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: screenWidth * 0.08,
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.red,
                            ),
                          ),
                        ),
                        Text("Specification",
                            style: GoogleFonts.urbanist(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: themeProvider.isDarkMode ? AppColors.whiteColor : AppColors.blackColor,
                              letterSpacing: 0.8,
                            ))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  powerdBySection(),
                  SizedBox(height: screenHeight * 0.02,),
                  Container(
                    width: screenWidth*.90,
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        squareContainer(
                          assetImage: 'assets/images/specification/cpu.png',
                          title: 'Processor',
                          requiredIcon: false,
                          specify: 'MediaTek Helio G99 6nm 2.2GHz Octa Core',
                          context: context,
                        ),
                        squareContainer(
                          assetImage: 'assets/images/specification/file.png',
                          title: 'Storage',
                          requiredIcon: false,
                          specify: 'ROM 128GB\n\n',
                          context: context,
                        ),
                      ],),
                  ),
                  SizedBox(height: screenHeight * 0.02,),
                  rectangleContainer(
                    assetImage: 'assets/images/specification/square.png',
                    title: 'Display',
                    specify: '6.7" FHD+ AMOLED GG5 120Hz\nPunch Hole ',
                    context: context,
                  ),
                  SizedBox(height: screenHeight * 0.02,),
                  Container(
                    width: screenWidth*.90,
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        squareContainer(
                          assetImage: 'assets/images/specification/chip.png',
                          title: 'Ram',
                          requiredIcon: true,
                          specify: '16GB (8GB Expandable RAM)',
                          context: context,
                        ),
                        squareContainer(
                          assetImage: 'assets/images/specification/sim.png',
                          title: 'Sim Card',
                          requiredIcon: false,
                          specify: 'Nano+Nano/Micro\nTF Card',
                          context: context,
                        ),
                      ],),
                  ),
                  SizedBox(height: screenHeight * 0.02,),
                  rectangleContainer(
                    assetImage: 'assets/images/specification/camera.png',
                    title: 'Camera',
                    specify: '64MP + 2MP Macro Rear & 32MP Super Selfie with Display Flash',
                    context: context,
                  ),
                  SizedBox(height: screenHeight * 0.02,),
                  Container(
                    width: screenWidth*.90,
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        squareContainer(
                          assetImage: 'assets/images/specification/network.png',
                          title: 'Network',
                          requiredIcon: false,
                          specify: '4G, 3G, 2G',
                          context: context,
                        ),
                        squareContainer(
                          assetImage: 'assets/images/specification/battery.png',
                          title: 'Battery',
                          requiredIcon: false,
                          specify: '5000mAh ',
                          context: context,
                        ),
                      ],),
                  ),
                  SizedBox(height: screenHeight * 0.02,),
                  rectangleContainer(
                    assetImage: 'assets/images/specification/finger.png',
                    title: 'Device Sensors',
                    specify: 'Fingerprint/Proximity/Light/Gravity/Magnetic/Gyro Sensor',
                    context: context,
                  ),
                  SizedBox(height: screenHeight * 0.02,),
                ],
              ),
            ),
          ),
          Container(
            height: screenHeight * 0.09,
            decoration: BoxDecoration(
              color: isDarkMode ? Color(0xff181818) : Colors.white,
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
          )
        ],
      ),
    );
  }

  Widget powerdBySection() {
    final screenHeight = MediaQuery.of(context).size.height * 1;
    final screenWidth = MediaQuery.of(context).size.width * 1;
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
    return Container(
      width: screenWidth * 0.90,
      height: screenHeight * 0.12,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: isDarkMode ? AppColors.blackOpColor : AppColors.whiteColor,
        border: Border.all(width: 1, color:isDarkMode ? AppColors.blackColor:  AppColors.borderColor),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0, left: 20, right: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Powered by",
                    style: GoogleFonts.urbanist(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: themeProvider.isDarkMode ? AppColors.borderColor.withOpacity(0.8) : AppColors.blackOpColor,
                      letterSpacing: 0.2,
                    )),
                Container(
                  height: screenWidth * 0.08,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: screenWidth * 0.08,
                        child: Text("Android",
                            style: GoogleFonts.urbanist(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff34A853),
                              letterSpacing: 0.8,
                            )),
                      ),
                      Container(
                        height: screenWidth * 0.05,
                        child: Text("TM",
                            style: GoogleFonts.urbanist(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff34A853),
                              letterSpacing: 0.8,
                            )),
                      ),
                      Container(
                        height: screenWidth * 0.08,
                        width: screenWidth * 0.1,
                        child: Center(
                          child: Text("14",
                              style: GoogleFonts.urbanist(
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff34A853),
                                letterSpacing: 0.8,
                              )),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Container(
                width: screenWidth * 0.2,
                height: screenHeight * 0.12,
                // color: Colors.white,
                alignment: Alignment.bottomCenter,
                child: Image.asset('assets/images/specification/android.png')),
          ],
        ),
      ),
    );
  }

  Widget squareContainer({
    required String assetImage,
    required String title,
    required bool requiredIcon,
    required String specify,
    required BuildContext context,
  }) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;

    return Container(
      width: screenWidth * 0.43,
      height: screenHeight * 0.22,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: isDarkMode ? AppColors.blackOpColor : AppColors.whiteColor,
        border: Border.all(width: 1, color:isDarkMode ? AppColors.blackColor:  AppColors.borderColor),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0,),
        child:  Container(
          height: screenHeight*0.14,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: screenWidth * 0.43,
                alignment: Alignment.bottomLeft,
                child: Image.asset(assetImage),
              ),
              SizedBox(height: screenHeight*0.015,),
              Row(
                children: [
                  Text(
                    title,
                    style: GoogleFonts.urbanist(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: isDarkMode ? AppColors.borderColor.withOpacity(0.8) : AppColors.blackColor.withOpacity(0.5),
                      letterSpacing: 0.2,
                    ),
                  ),
                  if (requiredIcon)...[
                    SizedBox(width:screenWidth*0.015),
                    Icon(
                      Icons.arrow_forward_ios_outlined,
                      size: 16,
                      color: AppColors.redColor,
                    ),
                  ]

                ],
              ),
              SizedBox(height:screenHeight*0.01),
              Text(
                specify,
                style: GoogleFonts.urbanist(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: isDarkMode ? AppColors.whiteColor.withOpacity(0.8) : AppColors.blackColor,
                  letterSpacing: 0.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget rectangleContainer({
    required String assetImage,
    required String title,
    required String specify,
    required BuildContext context,
  }) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;

    return Container(
      width: screenWidth * 0.90,
      height: screenHeight * 0.19,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: isDarkMode ? AppColors.blackOpColor : AppColors.whiteColor,
        border: Border.all(width: 1, color:isDarkMode ? AppColors.blackColor:  AppColors.borderColor),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0,),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Container(
              width: screenWidth * 0.3,
              // color: Colors.white,
              alignment: Alignment.bottomLeft,
              child: Image.asset(assetImage),
            ),
            SizedBox(height:screenHeight*0.01),
                Text(
                  title,
                  style: GoogleFonts.urbanist(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: isDarkMode ? AppColors.borderColor.withOpacity(0.8) : AppColors.blackColor.withOpacity(0.5),
                    letterSpacing: 0.2,
                  ),
                ),
            SizedBox(height:screenHeight*0.01),
            Text(
              specify,
              style: GoogleFonts.urbanist(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: isDarkMode ? AppColors.whiteColor.withOpacity(0.8) : AppColors.blackColor,
                letterSpacing: 0.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
