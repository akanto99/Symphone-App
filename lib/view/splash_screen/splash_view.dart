import 'package:flutter/material.dart';
import 'package:symphone_app/res/color.dart';
import 'package:symphone_app/view_model/services/splash_services.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    SplashService().navigateAfterDelay(context);
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Container(
          height: screenHeight,
          width: screenWidth,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: screenHeight * 0.2,
                width: screenWidth*0.45,
                child: Image.asset('assets/images/dart.png'),
              ),

              SizedBox(height: screenHeight*0.02),
              Text(
                'KEEP IN TOUCH',
                style: TextStyle(
                  color:  AppColors.blackColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 4,
                ),
              ),
              Text(
                'WITH US',
                style: TextStyle(
                  color:  AppColors.blackColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 4,
                ),
              ),
              SizedBox(height: screenHeight*0.02),
              Container(
                height: screenHeight * 0.03,
                width: screenWidth * 0.06,
                child: CircularProgressIndicator(
                  color: AppColors.blackColor,
                  strokeWidth: 3,
                  backgroundColor:  AppColors.whiteColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
