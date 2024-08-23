import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jirawala_bullion/core/app_colors.dart';
import 'package:jirawala_bullion/core/app_routes.dart';
import 'package:jirawala_bullion/modules/dashboard/dashboard_screen.dart';
import 'package:jirawala_bullion/modules/login/login_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<bool> isLoggedIn() async {
    await GetStorage.init();
    return GetStorage().read('token') != null;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: isLoggedIn(),
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return GetMaterialApp(
            routes: AppRoutes.routes,
            initialRoute: (snapshot.data ?? false) ? DashboardScreen.routeName : LoginScreen.routeName,
          );
        }
        return const Material(
          color: AppColors.black,
          child: Center(child: CircularProgressIndicator(color: AppColors.gold)),
        );
      },
    );
  }
}
