import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jirawala_bullion/core/app_colors.dart';
import 'package:jirawala_bullion/core/app_extensions.dart';
import 'package:jirawala_bullion/core/app_styles.dart';
import 'package:jirawala_bullion/modules/users/user.dart';
import 'package:jirawala_bullion/modules/users/users_controller.dart';

class UsersWidget extends StatelessWidget {
  const UsersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return GetBuilder(
      autoRemove: false,
      init: UsersController(),
      builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 2.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: TextField(
                onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
                controller: controller.searchUser,
                cursorColor: AppColors.gold,
                style: AppStyles.whiteText,
                decoration: InputDecoration(
                  hintText: "Search",
                  hintStyle: AppStyles.whiteText,
                  suffixIcon: const Icon(Icons.search),
                  contentPadding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: AppColors.gold),
                    borderRadius: BorderRadius.circular(10.w),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: AppColors.gold),
                    borderRadius: BorderRadius.circular(10.w),
                  ),
                ),
              ),
            ),
            SizedBox(height: 3.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Text(
                "Users",
                style: themeData.textTheme.titleMedium?.copyWith(color: AppColors.gold),
              ),
            ),
            const Divider(color: AppColors.gold, thickness: 2),
            Expanded(
              child: Obx(
                () => ListView.separated(
                  itemBuilder: (context, index) {
                    User user = controller.searchedUsers[index];

                    return ListTile(
                      visualDensity: VisualDensity.compact,
                      title: Text(user.name ?? '', style: AppStyles.goldText),
                      subtitle: Text(user.mobileNo ?? '', style: AppStyles.whiteText),
                      trailing: IconButton(onPressed: () {}, icon: const Icon(Icons.delete, color: AppColors.gold)),
                    );
                  },
                  separatorBuilder: (_, __) => const Divider(color: AppColors.gold),
                  itemCount: controller.searchedUsers.length,
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
