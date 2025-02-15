import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:symphone_app/provider/DarkAndLightTheme/theme_provider.dart';
import 'package:symphone_app/res/color.dart';
import 'package:symphone_app/view/screens/home_screen.dart';
import 'package:symphone_app/view/screens/social_screen.dart';
import 'package:symphone_app/view/screens/website_screen.dart';

class NavigationScreen extends StatefulWidget {
  final int initialIndex;

  const NavigationScreen({super.key,this.initialIndex =1});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> with SingleTickerProviderStateMixin {
  int _currentIndex = 1;
  late AnimationController _bounceController;

  final List<String> _labels = ['Website', 'Home', 'Social'];
  final List<String> _svgPaths = [
    'assets/images/navImages/web.svg',
    'assets/images/navImages/home.svg',
    'assets/images/navImages/social.svg',
  ];
  final List<Widget> _pages = [
    WebsiteScreen(),
    HomeScreen(),
    SocialScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _bounceController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
      lowerBound: 0.0,
      upperBound: 1.0,
    );
    _currentIndex = widget.initialIndex;
  }

  @override
  void dispose() {
    _bounceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;

    // Debugging: Print theme mode
    print("Current Theme Mode: ${isDarkMode ? 'Dark' : 'Light'}");


    return Scaffold(
      backgroundColor: isDarkMode ? AppColors.blackColor :null,
      body: _pages[_currentIndex],
      bottomNavigationBar: Container(
        height: screenHeight * 0.09,
        decoration: BoxDecoration(
          color: isDarkMode ? Color(0xff181818) : Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(35),
            topRight: Radius.circular(35),
          ),
          boxShadow: [
            BoxShadow(
              color:isDarkMode ? AppColors.blackColor : Colors.black.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 8,
              offset: Offset(0, -2),
            ),
          ],
          border: Border(
            top: BorderSide(width: 2, color: isDarkMode ? AppColors.blackOpColor:AppColors.borderColor),
            left: BorderSide(width: 2, color:isDarkMode ? AppColors.blackOpColor: AppColors.borderColor),
            right: BorderSide(width: 2, color: isDarkMode ? AppColors.blackOpColor:AppColors.borderColor),
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(_labels.length, (index) {
            bool isSelected = _currentIndex == index;
            return InkWell(
              onTap: () {
                setState(() {
                  _currentIndex = index;
                  _bounceController.reset();
                  _bounceController.forward();
                });
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedBuilder(
                      animation: _bounceController,
                      builder: (context, child) {
                        double scale = isSelected ? 1.3 + _bounceController.value * 0.1 : 1.0;
                        return Transform.scale(
                          scale: scale,
                          child: child,
                        );
                      },
                      child: Container(
                        width: screenWidth * 0.14,
                        child: SvgPicture.asset(
                          _svgPaths[index],
                          height: 24,
                          width: 24,
                          colorFilter: ColorFilter.mode(
                            isSelected ? AppColors.redColor :
                            (isDarkMode ? AppColors.whiteColor : Colors.black),
                            // AppColors.greyColor,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      _labels[index],
                      style: TextStyle(
                        color: isSelected
                            ? AppColors.redColor
                            : (isDarkMode ? AppColors.whiteColor : Colors.black), // Adjust text color based on mode
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
    );
  }
}
