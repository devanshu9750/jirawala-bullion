import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jirawala_bullion/core/app_colors.dart';
import 'package:jirawala_bullion/core/app_extensions.dart';
import 'package:jirawala_bullion/core/app_styles.dart';
import 'package:jirawala_bullion/modules/home/home_controller.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: HomeController(),
        builder: (controller) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                  child: ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(4.w)),
                    child: Table(
                      children: [
                        TableRow(
                          children: List.generate(
                            controller.columns.length,
                            (index) {
                              String column = controller.columns[index];

                              return Container(
                                padding: EdgeInsets.symmetric(vertical: 1.h),
                                color: AppColors.gold1,
                                child: index == 0
                                    ? Padding(
                                        padding: EdgeInsets.only(left: 3.w),
                                        child: Text(
                                          column,
                                          style: const TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                      )
                                    : Center(
                                        child: Text(
                                          column,
                                          style: const TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                      ),
                              );
                            },
                          ),
                        ),
                        TableRow(
                          children: List.generate(
                            controller.columns.length,
                            (index) {
                              String column = controller.columns[index];

                              return Container(
                                padding: EdgeInsets.symmetric(vertical: 1.h),
                                decoration: BoxDecoration(border: Border.all(color: AppColors.gold)),
                                child: index == 0
                                    ? Padding(
                                        padding: EdgeInsets.only(left: 3.w),
                                        child: Text("Gold", style: AppStyles.whiteText.copyWith(fontWeight: FontWeight.bold)),
                                      )
                                    : Center(child: Text(column, style: AppStyles.whiteText)),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                  child: ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(4.w)),
                    child: Table(
                      children: [
                        TableRow(
                          children: List.generate(
                            controller.columns.length,
                            (index) {
                              String column = controller.columns[index];

                              return Container(
                                padding: EdgeInsets.symmetric(vertical: 1.h),
                                color: AppColors.gold1,
                                child: index == 0
                                    ? Padding(
                                        padding: EdgeInsets.only(left: 2.w),
                                        child: Text(
                                          column,
                                          style: const TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                      )
                                    : Center(
                                        child: Text(
                                          column,
                                          style: const TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                      ),
                              );
                            },
                          ),
                        ),
                        TableRow(
                          children: List.generate(
                            controller.columns.length,
                            (index) {
                              String column = controller.columns[index];

                              return Container(
                                padding: EdgeInsets.symmetric(vertical: 1.h),
                                decoration: BoxDecoration(border: Border.all(color: AppColors.gold)),
                                child: index == 0
                                    ? Padding(
                                        padding: EdgeInsets.only(left: 2.w),
                                        child: Text("Gold", style: AppStyles.whiteText.copyWith(fontWeight: FontWeight.bold)),
                                      )
                                    : Center(child: Text(column, style: AppStyles.whiteText)),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }
}
