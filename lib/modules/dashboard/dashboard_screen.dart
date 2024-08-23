import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jirawala_bullion/core/app_colors.dart';
import 'package:jirawala_bullion/core/app_extensions.dart';
import 'package:jirawala_bullion/core/app_images.dart';
import 'package:jirawala_bullion/core/app_styles.dart';
import 'package:jirawala_bullion/modules/dashboard/dashboard_controller.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});
  static const String routeName = '/dashboard';

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: DashboardController(),
        builder: (controller) {
          return Scaffold(
            floatingActionButton: controller.isAdmin
                ? FloatingActionButton(
                    backgroundColor: AppColors.gold1,
                    onPressed: () {},
                    child: const Icon(CupertinoIcons.person_add),
                  )
                : null,
            backgroundColor: AppColors.black,
            body: SafeArea(
              child: Column(
                children: [
                  SizedBox(height: 2.h),
                  Image.asset(AppImages.dashboardAppbar),
                  SizedBox(height: 4.h),
                  Expanded(child: Container()),
                ],
              ),
            ),
            bottomNavigationBar: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => controller.bottomNavIndex.value = 0,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(AppImages.home, height: 4.h),
                        SizedBox(height: 1.h),
                        const Text("Home", style: AppStyles.whiteText),
                        SizedBox(height: 1.h),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => controller.bottomNavIndex.value = 1,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(controller.isAdmin ? AppImages.users : AppImages.home, height: 4.h),
                        SizedBox(height: 1.h),
                        const Text("Users", style: AppStyles.whiteText),
                        SizedBox(height: 1.h),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: controller.logout,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(AppImages.logout, height: 4.h),
                        SizedBox(height: 1.h),
                        const Text("Logout", style: AppStyles.whiteText),
                        SizedBox(height: 1.h),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }
}
