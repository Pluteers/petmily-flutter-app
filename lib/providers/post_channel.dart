import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

final dio = Dio();

class PostChannel {
  static TextEditingController channelTitleController = TextEditingController();

  static Future<void> postChannel(category) async {
    var accessToken =
        "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJBY2Nlc3NUb2tlbiIsImV4cCI6MTY4NDgxMjI1NiwiZW1haWwiOiJ0ZXN0NEBuYXZlci5jb20ifQ.pEG7RJAy4CK7go9keWwaYDGiIePZm613hp-CLLVA8NucH1QKYs_RWNAenQNf_Nmq4uQB9m8MIJIRet4bk21IHA";

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
