import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jirawala_bullion/modules/login/login_screen.dart';

class DashboardController extends GetxController {
  final isAdmin = GetStorage().read('isAdmin');
  final bottomNavIndex = 0.obs;

  Future<void> logout() async {
    await GetStorage().erase();
    Get
      ..back()
      ..toNamed(LoginScreen.routeName);
  }
}
