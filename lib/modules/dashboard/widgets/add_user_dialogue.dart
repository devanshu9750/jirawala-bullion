import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jirawala_bullion/core/app_colors.dart';
import 'package:jirawala_bullion/core/app_extensions.dart';
import 'package:jirawala_bullion/core/app_styles.dart';

class AddUserDialogue extends StatefulWidget {
  const AddUserDialogue({super.key});

  @override
  State<AddUserDialogue> createState() => _AddUserDialogueState();
}

class _AddUserDialogueState extends State<AddUserDialogue> {
  final mobileNo = TextEditingController();
  final name = TextEditingController();
  final enableSubmit = false.obs;

  @override
  void initState() {
    super.initState();
    mobileNo.addListener(() {
      enableSubmit.value = mobileNo.text.length == 10 && mobileNo.text.isPhoneNumber && name.text.isNotEmpty;
    });
    name.addListener(() {
      enableSubmit.value = mobileNo.text.length == 10 && mobileNo.text.isPhoneNumber && name.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 3.h),
          Text("Add User", style: themeData.textTheme.titleMedium?.copyWith(color: AppColors.gold)),
          SizedBox(height: 2.h),
          TextField(
            controller: name,
            cursorColor: AppColors.gold,
            autofocus: true,
            style: AppStyles.whiteText,
            decoration: const InputDecoration(
              labelText: "Name",
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.gold)),
              labelStyle: AppStyles.goldText,
            ),
          ),
          SizedBox(height: 2.h),
          TextField(
            controller: mobileNo,
            cursorColor: AppColors.gold,
            style: AppStyles.whiteText,
            maxLength: 10,
            decoration: const InputDecoration(
              labelText: "Mobile No",
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.gold)),
              labelStyle: AppStyles.goldText,
              helperStyle: AppStyles.goldText,
            ),
          ),
          SizedBox(height: 1.h),
          Row(
            children: [
              Expanded(child: TextButton(onPressed: Get.back, child: const Text("Cancel", style: AppStyles.goldText))),
              SizedBox(width: 2.w),
              Expanded(
                child: Obx(
                  () => FilledButton(
                    style: enableSubmit.value ? AppStyles.filledButtonGold : AppStyles.filledButtonGoldDisabled,
                    onPressed: enableSubmit.value ? () => Get.back(result: {"mobile_no": mobileNo.text, "name": name.text}) : null,
                    child: const Text("Save"),
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 2.h)
        ],
      ),
    );
  }
}
