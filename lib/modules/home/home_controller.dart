// ignore_for_file: argument_type_not_assignable_to_error_handler
import 'dart:convert';
import 'package:get/get.dart';
import 'package:jirawala_bullion/core/api_endpoints.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class HomeController extends GetxController {
  late final WebSocketChannel channel;
  final columns1 = ['DESC', 'BID', 'ASK', 'HIGH', 'LOW'];
  final columns2 = ['COMMODITY', 'BUY', 'SELL'];
  final prevData = [].obs;
  final data = [].obs;

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
