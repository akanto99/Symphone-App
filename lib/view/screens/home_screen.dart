import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:symphone_app/provider/DarkAndLightTheme/theme_provider.dart';
import 'package:symphone_app/res/color.dart';
import 'package:symphone_app/responsive/responsive_ui.dart';
import 'package:symphone_app/utils/routes/routes_name.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<String> trendingImage=[
    'assets/images/home_icons/items/Fish.png',
    'assets/images/home_icons/items/Fish_1.png',
    'assets/images/home_icons/items/Fish_2.png',
  ];
  List<String> trendingImageName=[
    'Mobiles',
    'Watches',
    'Accessories',
  ];
  List<String> gamesImage=[
    'assets/images/home_icons/items/image1.png',
    'assets/images/home_icons/items/image2.png',
    'assets/images/home_icons/items/image3.png',
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          // backgroundColor: Colors.white,
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

    return SingleChildScrollView(
      child: Container(
          width: screenWidth,
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
            children: [
              SizedBox(
                height: screenHeight * 0.02,
              ),
              Container(
                width: screenWidth * 0.90,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("My Symphony",
                        style: GoogleFonts.urbanist(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: themeProvider.isDarkMode ? AppColors.whiteColor : AppColors.blackColor,
                          letterSpacing: 0.8,
                        )),
                    GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, RoutesName.cardScreen);
                      },
                      child: Container(
                        width: screenWidth * 0.14,
                        child: SvgPicture.asset(
                          'assets/images/home_icons/Menu.svg',
                          height: 24,
                          width: 24,
                          colorFilter: ColorFilter.mode(
                            isDarkMode ? AppColors.whiteColor : AppColors.blackColor,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              Container(
                width: screenWidth * 0.90,
                height: screenHeight * 0.2,
                decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                    image: AssetImage('assets/images/home_icons/mysymphone.png'),
                    fit: BoxFit.cover,
                  ),
                  border: Border.all(
                    color: isDarkMode ? AppColors.blackOpColor : AppColors.borderColor,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              SizedBox(height: screenHeight * 0.02,),
              Container(
                width: screenWidth * 0.90,
                height: screenHeight * 0.18,
                decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                    image: AssetImage('assets/images/home_icons/needSupport.png'),
                    fit: BoxFit.cover,
                  ),
                  border: Border.all(
                    color: isDarkMode ? AppColors.blackColor : AppColors.borderColor,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child:Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: (){},
                        child: Container(
                          child: Row(
                            children: [
                              Image.asset("assets/images/home_icons/call.png"),
                              SizedBox(width: screenWidth*0.03,),
                              Text("Need Help?",
                                  style: GoogleFonts.urbanist(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color:  AppColors.whiteColor,
                                    letterSpacing: 0.8,
                                  )),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: (){},
                        child: Container(
                          height: screenHeight*0.052,
                          width: screenWidth*0.38,
                          decoration: BoxDecoration(
                              color: AppColors.whiteColor,
                            borderRadius: BorderRadius.circular(10)
                          ),
      
                          child: Center(
                            child: Text("Check Support",
                                style: GoogleFonts.urbanist(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color:  AppColors.blackColor,
                                  letterSpacing: 0.3,
                                )),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.02,),
              TitleContainer("Trending items"),

              SizedBox(height: screenHeight * 0.02,),
              Container(
                width: screenWidth * 0.90,
                height: screenHeight * 0.16,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: trendingImage.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(right: 10.0),
                      width: screenWidth * 0.285,
                      // height: screenHeight * 0.18,
                      alignment: Alignment.topCenter,
                      decoration: BoxDecoration(
                        // color: Colors.white,
                        image: DecorationImage(
                          image: AssetImage(trendingImage[index]),
                          fit: BoxFit.contain,
                        ),

                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child:  Padding(
                        padding: const EdgeInsets.only(top:10.0),
                        child: Text(trendingImageName[index],
                            style: GoogleFonts.urbanist(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color:AppColors.blackColor,
                              letterSpacing: 0.8,
                            )),
                      )
                    );
                  },
                ),
              ),
              SizedBox(height: screenHeight * 0.02,),

              TitleContainer("Entertainment"),
              SizedBox(height: screenHeight * 0.02,),
              Container(
                width: screenWidth * 0.90,
                height: screenHeight * 0.2,
                decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                    image: AssetImage('assets/images/home_icons/items/entertain.png'),
                    fit: BoxFit.cover,
                  ),
                  border: Border.all(
                    color: isDarkMode ? AppColors.blackColor : AppColors.borderColor,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              SizedBox(height: screenHeight * 0.02,),
              TitleContainer("E-warranty card"),
              SizedBox(height: screenHeight * 0.02,),

              Container(
                height: screenHeight * 0.16,
                width: screenWidth * 0.90,
                decoration: BoxDecoration(
                  color:  AppColors.blackOpColor,
                  border: Border.all(width: 1, color:AppColors.blackOpColor),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: screenHeight * 0.13,
                            width: screenWidth * 0.15,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                 Color(0xffA2C6B7),
                                 Color(0xff77938E),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 5.0),
                                  child: Container(
                                    height: screenHeight * 0.008,
                                    width: screenWidth * 0.018,
                                    decoration: BoxDecoration(
                                      color: AppColors.blackColor,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Center(
                                    child: Text(
                                      "Helio",
                                      style: GoogleFonts.urbanist(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.whiteColor,
                                        letterSpacing: 0.8,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: screenHeight*0.01,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: screenWidth*0.04,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Helio 50",
                                style: GoogleFonts.lato(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.whiteColor,
                                  letterSpacing: 0.2,
                                  height: screenHeight*0.0015
                                ),
                              ),
                              Text(
                                "Valid for 406 Days",
                                style: GoogleFonts.lato(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.borderColor.withOpacity(0.7),
                                  letterSpacing: 0.2,
                                    height: screenHeight*0.0015
                                ),
                              ),
                              Text(
                                "Expiry Date: December 10, 2024",
                                style: GoogleFonts.lato(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.borderColor.withOpacity(0.7),
                                  letterSpacing: 0.2,

                                ),
                              ),
                            ],
                          )

                        ],
                      ),
                      Icon(Icons.arrow_forward_ios_outlined,size:20,color: AppColors.redColor,)
                    ],
                  ),
                )
              ),
              SizedBox(height: screenHeight * 0.02,),

              Container(
                width: screenWidth * 0.90,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        "Games",
                        style: GoogleFonts.urbanist(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: isDarkMode ? AppColors.whiteColor : AppColors.blackColor,
                          letterSpacing: 0.8,
                        )),
                    Row(
                      children: [
                        InkWell(
                          onTap:(){
                            print("Tap");
                          },
                          child: Text(
                              "See More",
                              style: GoogleFonts.urbanist(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color:  AppColors.redColor,
                                letterSpacing: 0.8,
                              )),
                        ),
                        SizedBox(width: screenWidth*0.02,),
                        Icon(Icons.arrow_forward_ios_outlined,size:20,color: AppColors.redColor,)
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.02,),
              Container(
                width: screenWidth * 0.90,
                height: screenHeight * 0.16,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: trendingImage.length,
                  itemBuilder: (context, index) {
                    return Container(
                        margin: EdgeInsets.only(right: 10.0),
                        width: screenWidth * 0.285,
                        alignment: Alignment.topCenter,
                        decoration: BoxDecoration(
                          // color: Colors.white,
                          image: DecorationImage(
                            image: AssetImage(gamesImage[index]),
                            fit: BoxFit.contain,
                          ),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                    );
                  },
                ),
              ),
              SizedBox(height: screenHeight * 0.02,),
              Container(
                width: screenWidth * 0.90,
                height: screenHeight * 0.17,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/home_icons/items/Group 1.png'),
                    fit: BoxFit.cover,
                  ),

                  borderRadius: BorderRadius.circular(20.0),
                ),
                child:Container(
                  height: screenHeight*0.045,
                  width: screenWidth*0.4,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10)
                  ),

                  child: Center(
                    child: Text("JOIN SOCIAL COMMUNITY",
                        style: GoogleFonts.urbanist(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color:  AppColors.whiteColor,
                          letterSpacing: 0.8,
                        )),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.02,),

            ],
          )),
    );
  }

  Widget TitleContainer(String title){
    final screenHeight = MediaQuery.of(context).size.height * 1;
    final screenWidth = MediaQuery.of(context).size.width * 1;
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
    return Container(
      width: screenWidth * 0.90,
      child: Text(
          title,
          style: GoogleFonts.urbanist(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: isDarkMode ? AppColors.whiteColor : AppColors.blackColor,
            letterSpacing: 0.8,
          )),
    );
  }
}
