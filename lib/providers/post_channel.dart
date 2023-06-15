import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

final dio = Dio();

class PostChannel {
  static TextEditingController channelTitleController = TextEditingController();

  static Future<void> postChannel(category) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString('token');

    var response = await dio.post(
      "http://petmily.duckdns.org/channel",
      data: {
        'channelName': channelTitleController.text,
        'categoryId': category,
      },
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json'
        },
      ),
    );

    final responseData = response.data;
    var resData = responseData;
    log('channelPostSuccess : $resData');
  }
}
