import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jirawala_bullion/core/api_endpoints.dart';
import 'package:jirawala_bullion/core/api_request.dart';
import 'package:jirawala_bullion/modules/dashboard/widgets/add_user_dialogue.dart';
import 'package:jirawala_bullion/modules/login/login_screen.dart';
import 'package:jirawala_bullion/modules/users/users_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class DashboardController extends GetxController {
  final isAdmin = GetStorage().read('isAdmin');
  final bottomNavIndex = 0.obs;

  void contact() => launchUrl(Uri.parse("tel:+917383593262"));

  Future<void> showAddUserDialogue() async {
    Map<String, dynamic>? response = await showDialog(
      context: Get.context!,
      builder: (_) {
        return AlertDialog(backgroundColor: Colors.grey[850], content: const AddUserDialogue(), contentPadding: EdgeInsets.zero);
      },
    );
    if (response == null) return;
    response = await ApiRequest.post(apiEndpoint: ApiEndpoints.addUser, params: response);
    if (response == null) return;
    if (Get.isRegistered<UsersController>()) Get.find<UsersController>().refreshUsers();
    bottomNavIndex.value = 1;
  }

  Future<void> logout() async {
    await GetStorage().erase();
    await Get.deleteAll(force: true);
    Get.offAllNamed(LoginScreen.routeName);
  }
}
