import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jirawala_bullion/core/api_endpoints.dart';
import 'package:jirawala_bullion/core/api_request.dart';
import 'package:jirawala_bullion/core/app_extensions.dart';
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
          backgroundColor: Colors.grey[850],
          title: const Text("Are you sure ?", style: AppStyles.whiteText),
          actions: [
            TextButton(onPressed: () => Get.back(result: false), child: const Text("Cancel", style: AppStyles.goldText)),
            SizedBox(width: 2.w),
            FilledButton(onPressed: () => Get.back(result: true), style: AppStyles.filledButtonGold, child: const Text("Delete")),
          ],
        );
      },
    );
    if ((response ?? false) && await deleteUser(user)) {
      users.remove(user);
      searchedUsers.remove(user);
    }
  }

  Future<bool> deleteUser(User user) async {
    final Map<String, dynamic>? response = await ApiRequest.post(apiEndpoint: ApiEndpoints.deleteUser, params: {"end_user_id": user.id});
    return response != null;
  }

  Future<List<User>?> getUsers() async {
    final Map<String, dynamic>? response = await ApiRequest.post(apiEndpoint: ApiEndpoints.usersList, params: {});
    if (response == null) return null;
    if (response['users'] is List) return (response['users'] as List).map((e) => User.fromJson(e)).toList();
    return null;
  }

  void refreshUsers() => getUsers().then((value) {
        users.value = value ?? <User>[];
        searchUser.clear();
      });

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
