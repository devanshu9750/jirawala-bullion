import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jirawala_bullion/core/app_colors.dart';
import 'package:jirawala_bullion/core/app_extensions.dart';
import 'package:jirawala_bullion/core/app_styles.dart';

class EditValueDialogue extends StatefulWidget {
  const EditValueDialogue({super.key, required this.title, required this.initialValue});
  final String title;
  final String initialValue;

  @override
  State<EditValueDialogue> createState() => _EditValueDialogueState();
}

class _EditValueDialogueState extends State<EditValueDialogue> {
  final valueController = TextEditingController();
  final enableUpdate = true.obs;

  @override
  void initState() {
    super.initState();
    valueController.text = widget.initialValue;
    valueController.addListener(() {
      enableUpdate.value = valueController.text.isNum;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 3.h),
          Text(widget.title, style: themeData.textTheme.titleMedium?.copyWith(color: AppColors.gold)),
          SizedBox(height: 3.h),
          TextField(
            controller: valueController,
            cursorColor: AppColors.gold,
            autofocus: true,
            style: AppStyles.whiteText,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: "Value",
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.gold)),
              labelStyle: AppStyles.goldText,
            ),
          ),
          SizedBox(height: 2.h),
          Row(
            children: [
              Expanded(child: TextButton(onPressed: Get.back, child: const Text("Cancel", style: AppStyles.goldText))),
              SizedBox(width: 2.w),
              Expanded(
                child: Obx(
                  () => FilledButton(
                    style: enableUpdate.value ? AppStyles.filledButtonGold : AppStyles.filledButtonGoldDisabled,
                    onPressed: enableUpdate.value ? () => Get.back(result: valueController.text) : null,
                    child: const Text("Update"),
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
