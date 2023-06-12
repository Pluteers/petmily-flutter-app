import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

final dio = Dio();

class PostChannel {
  static TextEditingController channelTitleController = TextEditingController();

  static Future<void> postChannel(category) async {
    var accessToken =
        "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJBY2Nlc3NUb2tlbiIsImV4cCI6MTY4NjA0MjgzOSwiZW1haWwiOiJ0ZXN0NEBuYXZlci5jb20ifQ.svOFWFpDQvIT0XPqf4D5fvBFIqULVE5hL_LaaNl3bC1AQ103lz9xtCofr_kbufXMi7CbNtyPG9feEOTUTbLIsw";

    var response = await dio.post(
      "http://petmily.duckdns.org/channel",
      data: {
        'channelName': channelTitleController.text,
        'categoryId': category,
      },
      options: Options(
        headers: {
          'Authorization': 'Bearer ' + accessToken,
          'Content-Type': 'application/json'
        },
      ),
    );

    final responseData = response.data;
    var resData = responseData;
    log('channelPostSuccess : $resData');
  }
}
