
import 'package:flutter/material.dart';
import 'package:symphone_app/utils/routes/routes_name.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.splash:
        // return MaterialPageRoute(builder: (BuildContext context) => const SplashView());
      case RoutesName.login:
        // return MaterialPageRoute(builder: (BuildContext context) => const LoginView());

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
