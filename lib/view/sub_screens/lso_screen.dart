import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:symphone_app/provider/DarkAndLightTheme/theme_provider.dart';
import 'package:symphone_app/res/color.dart';
import 'package:symphone_app/res/components/round_button.dart';
import 'package:symphone_app/responsive/responsive_ui.dart';
import 'package:symphone_app/view/navigation_bar.dart';
import 'package:symphone_app/view/widgets/customtext_with_formfield.dart';

class LsoScreen extends StatefulWidget {
  const LsoScreen({super.key});

  @override
  State<LsoScreen> createState() => _LsoScreenState();
}

class _LsoScreenState extends State<LsoScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isLoading = false;

  late TextEditingController lsoNumberController;


  int _currentIndex = 1;
  final List<String> _labels = ['Website', 'Home', 'Social'];
  final List<String> _svgPaths = [
    'assets/images/navImages/web.svg',
    'assets/images/navImages/home.svg',
    'assets/images/navImages/social.svg',
  ];

  @override
  void initState() {
    super.initState();
    lsoNumberController = TextEditingController();
  }

  @override
  void dispose() {
    lsoNumberController.dispose();
    super.dispose();
  }

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

    return  Form(
      key: formKey,
      child: Container(
        height: screenHeight,
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
                  SizedBox(height: screenHeight * 0.02,),
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

                        Text("LSO Query",
                            style: GoogleFonts.urbanist(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: themeProvider.isDarkMode ? AppColors.whiteColor : AppColors.blackColor,
                              letterSpacing: 0.8,
                            ))
                      ],
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.04,),
                  Container(
                    // height: screenHeight * 0.25,
                    width: screenWidth * .90,
                    decoration: BoxDecoration(
                      color: isDarkMode? AppColors.blackOpColor:AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(width: 1, color:isDarkMode ? AppColors.blackOpColor:  AppColors.redColor.withOpacity(0.2)),

                    ),
                    child: Column(
                      children: [

                        SizedBox(height: screenHeight * 0.02,),

                        Container(
                          width: screenWidth*0.80,
                          child: Text("Service Tracking",
                            style: GoogleFonts.urbanist(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: themeProvider.isDarkMode ? AppColors.whiteColor: AppColors.blackColor,
                              letterSpacing: 0.8,
                            ),),
                        ),
                        SizedBox(height: screenHeight * 0.02,),


                        CustomTextFieldWithFormField(
                          titleText: 'Enter LSO',
                          requiredStar: "",
                          placeholder: 'eg : PAN-00950100',
                          controller: lsoNumberController,
                          validator: (value) {
                            if (lsoNumberController.text == null || lsoNumberController.text.isEmpty) {
                              return 'LSO Number is required.';
                            } else if (lsoNumberController.text.length >=12) {
                              return 'LSO Number must be less than or equal to 12 characters.';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: screenHeight * 0.02,),

                        Container(
                          width: screenWidth*0.80,
                          alignment: Alignment.centerLeft,
                          child:RoundButton(
                            title: "Get Information",
                            loading: isLoading,
                            onPress: () async {
                              if (formKey.currentState!.validate()) {
                                setState(() {
                                  isLoading = true;
                                });
                                await Future.delayed(Duration(seconds: 2));

                                setState(() {
                                  isLoading = false;
                                });

                                print("LSO Query Successful!");
                              } else {
                                print("Form is not valid.");
                              }
                            },

                          ),),
                        SizedBox(height: screenHeight * 0.02,),

                      ],
                    ),
                  ),
                ],
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
      ),
    );
  }
}
