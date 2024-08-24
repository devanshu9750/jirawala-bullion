import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jirawala_bullion/core/api_endpoints.dart';
import 'package:jirawala_bullion/core/api_request.dart';
import 'package:jirawala_bullion/core/app_colors.dart';
import 'package:jirawala_bullion/core/app_styles.dart';
import 'package:jirawala_bullion/modules/users/user.dart';

class UsersController extends GetxController {
  final searchUser = TextEditingController();
  final users = <User>[].obs;
  final searchedUsers = <User>[].obs;

  Future<void> showDeleteUserDialogue(User user) async {
    bool? response = await showDialog(
      context: Get.context!,
      builder: (_) {
        return AlertDialog(
          backgroundColor: AppColors.black,
          title: const Text("Are you sure ?", style: AppStyles.whiteText),
          actions: [
            TextButton(onPressed: () => Get.back(result: false), child: const Text("Cancel", style: AppStyles.goldText)),
            FilledButton(onPressed: () => Get.back(result: true), style: AppStyles.filledButtonGold, child: const Text("Delete")),
          ],
        );
      },
    );
    if (response ?? false) deleteUser(user);
  }

  Future<bool> deleteUser(User user) async {
    final Map<String, dynamic>? response = await ApiRequest.post(apiEndpoint: ApiEndpoints.deleteUser, params: {"end_user_id": user.id});
    if (response == null) return false;
    users
      ..remove(user)
      ..refresh();
    searchedUsers
      ..remove(user)
      ..refresh();
    return true;
  }

  Future<List<User>?> getUsers() async {
    final Map<String, dynamic>? response = await ApiRequest.post(apiEndpoint: ApiEndpoints.usersList, params: {});
    if (response == null) return null;
    if (response['users'] is List) return (response['users'] as List).map((e) => User.fromJson(e)).toList();
    return null;
  }

  @override
  void onInit() {
    super.onInit();
    getUsers().then((value) {
      users.value = value ?? <User>[];
      searchedUsers.value = value ?? <User>[];
    });
    searchUser.addListener(
      () {
        if (searchUser.text.isBlank ?? true) {
          searchedUsers.value = users;
        } else {
          searchedUsers.value = users
              .where(
                (user) =>
                    (user.name?.toLowerCase().contains(searchUser.text.toLowerCase()) ?? false) ||
                    (user.mobileNo?.toLowerCase().contains(searchUser.text.toLowerCase()) ?? false),
              )
              .toList();
        }
      },
    );
  }
}
