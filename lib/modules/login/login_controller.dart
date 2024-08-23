import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jirawala_bullion/core/api_endpoints.dart';
import 'package:jirawala_bullion/core/api_request.dart';
import 'package:jirawala_bullion/modules/dashboard/dashboard_screen.dart';

class LoginController extends GetxController {
  final mobileNo = TextEditingController();
  final password = TextEditingController();
  final isAdminLogin = false.obs;

  Future<void> login() async {
    final Map<String, dynamic>? response = await ApiRequest.post(
      apiEndpoint: isAdminLogin.value ? ApiEndpoints.requestAccessAdmin : ApiEndpoints.requestAccessUser,
      params: {
        "mobile_no": mobileNo.text,
        "password": password.text,
      },
    );

    if (response == null) return;

    await GetStorage().write('token', response['token']);
    await GetStorage().write('isAdminLogin', isAdminLogin.value);

    Get
      ..back()
      ..toNamed(DashboardScreen.routeName);
  }
}
