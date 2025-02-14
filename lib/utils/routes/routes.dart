
import 'package:flutter/material.dart';
import 'package:symphone_app/utils/routes/routes_name.dart';
import 'package:symphone_app/view/screens/home_screen.dart';
import 'package:symphone_app/view/screens/social_screen.dart';
import 'package:symphone_app/view/screens/website_screen.dart';
import 'package:symphone_app/view/splash_screen/splash_view.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.splash:
        return MaterialPageRoute(builder: (BuildContext context) => const SplashScreen());
      case RoutesName.homeScreen:
        return MaterialPageRoute(builder: (BuildContext context) => const HomeScreen());
      case RoutesName.webScreen:
        return MaterialPageRoute(builder: (BuildContext context) => const WebsiteScreen());
      case RoutesName.socialScreen:
        return MaterialPageRoute(builder: (BuildContext context) => const SocialScreen());

      default:
        return _errorRoute();






    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return const Scaffold(
        body: Center(
          child: Text('No route defined'),
        ),
      );
    });
  }
}
