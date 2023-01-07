import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:customer_listing_desktop_app/Screens/AddCustomerScreen.dart';
import 'package:customer_listing_desktop_app/Screens/AuthScreens/AuthScreen.dart';
import 'package:customer_listing_desktop_app/Screens/HomeScreen.dart';
import 'package:customer_listing_desktop_app/Screens/SplashScreen.dart';
import 'package:customer_listing_desktop_app/utils/globals.dart';
import 'package:flutter/material.dart';

class ScreenRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {

      case '/':
        return MaterialPageRoute(builder: (_) => WindowBorder(
            color: primaryColorOfApp,
            width: 1,
            child: SplashScreen()));

      case 'AuthScreen':
        return MaterialPageRoute(builder: (_) => WindowBorder(
            color: primaryColorOfApp,
            width: 1,child: AuthScreen()));

      case 'HomeScreen':
        return MaterialPageRoute(builder: (_) => WindowBorder(
            color: primaryColorOfApp,
            width: 1,child: HomeScreen()));

      /*case 'NotificationScreen':
        return MaterialPageRoute(builder: (_) => NotificationScreen());*/

      case 'AddCustomerScreen':
        return MaterialPageRoute(builder: (_) => AddCustomerScreen());

      default:
        return MaterialPageRoute(builder: (_) => AuthScreen());
    }
  }
}