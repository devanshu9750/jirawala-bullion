import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:jirawala_bullion/core/api_endpoints.dart';
import 'package:jirawala_bullion/core/api_request.dart';
import 'package:jirawala_bullion/modules/users/user.dart';

class UsersController extends GetxController {
  final searchUser = TextEditingController();
  final users = <User>[].obs;
  final searchedUsers = <User>[].obs;

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
