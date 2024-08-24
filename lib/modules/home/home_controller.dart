import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jirawala_bullion/core/api_endpoints.dart';
import 'package:jirawala_bullion/core/api_request.dart';
import 'package:jirawala_bullion/modules/home/widgets/edit_value_dialogue.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class HomeController extends GetxController {
  late final WebSocketChannel channel;
  final columns1 = ['DESC', 'BID', 'ASK', 'HIGH', 'LOW'];
  final columns2 = ['COMMODITY', 'BUY', 'SELL'];
  final prevData = [].obs;
  final data = [].obs;

  Future<void> showUpdateValueDialogue({required Map data, required String column}) async {
    String? response = await showDialog(
      context: Get.context!,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          backgroundColor: Colors.grey[850],
          content: EditValueDialogue(title: "${data['commodity_name']} - ${column.toUpperCase()}", initialValue: data[column].toString()),
        );
      },
    );
    if (response == null) return;
    data[column] = response;
    List tempData = this.data;
    int index = tempData.indexWhere((element) => element['commodity_name'] == data['commodity_name']);
    if (index != -1) {
      tempData[index][column] = response;
      updateValue(tempData);
    }
  }

  Future<bool> updateValue(List data) async {
    Map<String, dynamic> params = {
      "gold_buy": data[5]['buy'],
      "gold_sell": data[5]['sell'],
      "silver_buy": data[6]['buy'],
      "silver_sell": data[6]['sell'],
      "silver_peti_buy": data[7]['buy'],
      "silver_peti_sell": data[7]['sell'],
      "gold_imp_buy": data[8]['buy'],
      "gold_imp_sell": data[8]['sell']
    };
    final Map<String, dynamic>? response = await ApiRequest.post(apiEndpoint: ApiEndpoints.updateValues, params: params);
    return response != null;
  }

  Future<void> setupSocket() async {
    final wsUrl = Uri.parse(ApiEndpoints.dataSocket);
    channel = WebSocketChannel.connect(wsUrl);

    await channel.ready;

    channel.stream.listen((message) {
      prevData.value = data;
      data.value = jsonDecode(message.toString().replaceAll('=>', ":"));
    });
  }

  @override
  void onInit() {
    super.onInit();
    setupSocket();
  }

  @override
  void onClose() {
    channel.sink.close();
    super.onClose();
  }
}
