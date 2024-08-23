import 'package:flutter/material.dart';
import 'package:jirawala_bullion/modules/dashboard/dashboard_screen.dart';
import 'package:jirawala_bullion/modules/login/login_screen.dart';

class AppRoutes {
  static Map<String, Widget Function(BuildContext)> routes = {
    LoginScreen.routeName: (context) => const LoginScreen(),
    DashboardScreen.routeName: (context) => const DashboardScreen(),
  };
}
