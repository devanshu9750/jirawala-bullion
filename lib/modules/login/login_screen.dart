import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jirawala_bullion/core/app_colors.dart';
import 'package:jirawala_bullion/core/app_extensions.dart';
import 'package:jirawala_bullion/core/app_images.dart';
import 'package:jirawala_bullion/modules/login/login_controller.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  static const String routeName = '/login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: GetBuilder(
          init: LoginController(),
          builder: (controller) {
            return SafeArea(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                height: 100.h,
                width: 100.w,
                decoration: BoxDecoration(image: DecorationImage(image: AssetImage(AppImages.loginBG), fit: BoxFit.cover)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 20.h),
                    TextField(
                      controller: controller.mobileNo,
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                      cursorColor: AppColors.gold,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        hintText: "Mobile No",
                        hintStyle: TextStyle(color: Colors.white),
                        border: InputBorder.none,
                      ),
                    ),
                    const Divider(color: AppColors.gold, height: 0, thickness: 2),
                    SizedBox(height: 2.h),
                    TextField(
                      controller: controller.password,
                      obscureText: true,
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                      cursorColor: AppColors.gold,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: "Password",
                        hintStyle: TextStyle(color: Colors.white),
                        border: InputBorder.none,
                      ),
                    ),
                    const Divider(color: AppColors.gold, height: 0, thickness: 2),
                    SizedBox(height: 5.h),
                    GestureDetector(
                      onTap: controller.login,
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.w),
                          gradient: const LinearGradient(
                            colors: [Color(0xffCB983F), Color(0xffFAD562), Color(0xffFAEF9F)],
                            stops: [0, 0.35, 1],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.w),
                          child: Obx(
                            () => Text(
                              controller.isAdminLogin.value ? "ADMIN LOG IN" : "LOG IN",
                              style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 2.h),
                    GestureDetector(
                      onTap: () => controller.isAdminLogin.toggle(),
                      child: Obx(
                        () => Text(
                          controller.isAdminLogin.value ? "User Login" : "Admin Login",
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
