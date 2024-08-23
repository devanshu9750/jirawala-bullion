import 'package:flutter/material.dart';
import 'package:jirawala_bullion/core/app_colors.dart';
import 'package:jirawala_bullion/core/app_extensions.dart';
import 'package:jirawala_bullion/core/app_images.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});
  static const String routeName = '/dashboard';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 2.h),
            Image.asset(AppImages.dashboardAppbar),
            SizedBox(height: 4.h),
          ],
        ),
      ),
    );
  }
}
