import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jirawala_bullion/core/app_colors.dart';
import 'package:jirawala_bullion/core/app_extensions.dart';
import 'package:jirawala_bullion/core/app_styles.dart';
import 'package:jirawala_bullion/modules/home/home_controller.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        autoRemove: false,
        init: HomeController(),
        builder: (controller) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                  child: ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(4.w)),
                    child: Obx(
                      () => controller.data.isEmpty
                          ? const SizedBox()
                          : Table(
                              columnWidths: {0: FixedColumnWidth(22.w)},
                              children: [
                                TableRow(
                                  children: List.generate(
                                    controller.columns1.length,
                                    (index) {
                                      String column = controller.columns1[index];

                                      return Container(
                                        padding: EdgeInsets.symmetric(vertical: 1.h),
                                        decoration: BoxDecoration(
                                          border: Border(
                                            right: BorderSide(color: index == controller.columns1.length - 1 ? AppColors.gold1 : Colors.black),
                                          ),
                                          color: AppColors.gold1,
                                        ),
                                        child: Center(
                                          child: Text(
                                            column,
                                            style: const TextStyle(fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                ...List.generate(
                                  5,
                                  (index) {
                                    return TableRow(
                                      children: List.generate(
                                        controller.columns1.length,
                                        (index1) {
                                          String data = controller.data[index].values.elementAt(index1).toString();
                                          bool changeBG = controller.prevData.isNotEmpty;
                                          Color bgColor = Colors.transparent;

                                          if (changeBG) {
                                            String prevData = controller.prevData[index].values.elementAt(index1).toString();
                                            changeBG = prevData.compareTo(data) != 0;
                                            if (changeBG) bgColor = prevData.compareTo(data) < 0 ? Colors.green : Colors.red;
                                          }

                                          return Container(
                                            height: 9.h,
                                            padding: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 1.w),
                                            decoration: BoxDecoration(
                                              color: bgColor,
                                              border: Border.all(color: AppColors.gold),
                                              borderRadius: index == 4 && index1 == 0
                                                  ? BorderRadius.only(bottomLeft: Radius.circular(4.w))
                                                  : index == 4 && index1 == 4
                                                      ? BorderRadius.only(bottomRight: Radius.circular(4.w))
                                                      : null,
                                            ),
                                            child: Center(
                                              child: Text(
                                                data,
                                                textAlign: TextAlign.center,
                                                style: AppStyles.whiteText.copyWith(fontWeight: FontWeight.bold, fontSize: 12),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    );
                                  },
                                )
                              ],
                            ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                  child: ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(4.w)),
                    child: Obx(
                      () => controller.data.isEmpty
                          ? const SizedBox()
                          : Table(
                              columnWidths: {
                                0: FlexColumnWidth(),
                                1: FixedColumnWidth(GetStorage().read('isAdmin') ? 28.w : 25.w),
                                2: FixedColumnWidth(GetStorage().read('isAdmin') ? 28.w : 25.w),
                              },
                              children: [
                                TableRow(
                                  children: List.generate(
                                    controller.columns2.length,
                                    (index) {
                                      String column = controller.columns2[index];

                                      return Container(
                                        padding: EdgeInsets.symmetric(vertical: 1.h),
                                        decoration: BoxDecoration(
                                          border: Border(
                                              right: BorderSide(color: index == controller.columns2.length - 1 ? AppColors.gold1 : Colors.black)),
                                          color: AppColors.gold1,
                                        ),
                                        child: Center(
                                          child: Text(
                                            column,
                                            style: const TextStyle(fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                ...List.generate(
                                  4,
                                  (index) {
                                    return TableRow(
                                      children: List.generate(
                                        controller.columns2.length,
                                        (index1) {
                                          String data = controller.data[index + 5].values.elementAt(index1).toString();

                                          return Container(
                                            height: 11.h,
                                            padding: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 1.w),
                                            decoration: BoxDecoration(
                                              border: Border.all(color: AppColors.gold),
                                              borderRadius: index == 3 && index1 == 0
                                                  ? BorderRadius.only(bottomLeft: Radius.circular(4.w))
                                                  : index == 3 && index1 == 2
                                                      ? BorderRadius.only(bottomRight: Radius.circular(4.w))
                                                      : null,
                                            ),
                                            child: GestureDetector(
                                              behavior: HitTestBehavior.translucent,
                                              onTap: GetStorage().read('isAdmin')
                                                  ? () => controller.showUpdateValueDialogue(
                                                        data: controller.data[index + 5],
                                                        column: controller.data[index + 5].keys.elementAt(index1).toString(),
                                                      )
                                                  : null,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Flexible(
                                                    child: Text(
                                                      data,
                                                      textAlign: TextAlign.center,
                                                      style: AppStyles.whiteText.copyWith(fontWeight: FontWeight.bold, fontSize: 12),
                                                    ),
                                                  ),
                                                  if (index1 != 0 && GetStorage().read('isAdmin'))
                                                    Padding(
                                                      padding: EdgeInsets.only(left: 2.w),
                                                      child: Icon(Icons.edit, color: AppColors.gold, size: 2.5.h),
                                                    )
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    );
                                  },
                                )
                              ],
                            ),
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
              ],
            ),
          );
        });
  }
}
