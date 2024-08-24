import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jirawala_bullion/core/api_endpoints.dart';
import 'package:jirawala_bullion/core/api_status.dart';

class ApiRequest {
  static Future<Map<String, dynamic>?> post({required String apiEndpoint, required Map<String, dynamic> params}) async {
    try {
      String? token = GetStorage().read('token');

      if (kDebugMode) {
        print("Token ===> $token");
        print("Params ===> ${jsonEncode(params)}");
        print("Request ===> ${Uri.http(ApiEndpoints.baseUrl, apiEndpoint)}");
      }

      final dio = Dio();

      final Response response = await dio.post(
        Uri.http(ApiEndpoints.baseUrl, apiEndpoint).toString(),
        data: {...params, 'token': token},
      );

      if (kDebugMode) {
        print("Response ===> ${response.data}");
      }

      if (response.data['status'] == ApiStatus.error) {
        Fluttertoast.showToast(msg: response.data['message'] ?? '');
        return null;
      }

      if (response.statusCode != 200) {
        Fluttertoast.showToast(msg: "Something went wrong");
        return null;
      }

      return response.data['contents'] ?? {'message': response.data['message']};
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      return null;
    }
  }
}
