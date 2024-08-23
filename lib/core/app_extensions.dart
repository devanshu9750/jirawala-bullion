import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

extension Dimension on num {
  double get h => MediaQuery.of(Get.context!).size.height * this / 100;
  double get w => MediaQuery.of(Get.context!).size.width * this / 100;
}
