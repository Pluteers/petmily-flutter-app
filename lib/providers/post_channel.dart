import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

final dio = Dio();

class PostChannel {
  static TextEditingController channelTitleController = TextEditingController();

  static Future<void> postChannel(category) async {
    var accessToken =
        "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJBY2Nlc3NUb2tlbiIsImV4cCI6MTY4MzU0ODc4MiwiZW1haWwiOiJ0ZXN0NEBuYXZlci5jb20ifQ.695ZHvXIJzsRet2BKluBhTTVBoqkN1pBmszSOva6xFxa0__7phktJYvobq9WWnARYx57WarddZ6tm2D5LbmU9Q";
    // dio.options.headers["Authorization"] = "Bearer $accessToken";
    // dio.options.headers["Content-Type"] = "application/json";

    var response = await dio.post(
      "http://petmily.duckdns.org/post/channel",
      data: {
        'channelName': channelTitleController.text,
        'categoryId': '1',
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



//Header : {   Authorization: Bearer (Access Token필요) }

// {
// "channelName" :"짱이의 일상2",
// "categoryId": "1"
// }