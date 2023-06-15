import 'dart:developer';
import 'package:flutter/material.dart';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

final dio = Dio();

class AddPost {
  static TextEditingController postTitleController = TextEditingController();
  static TextEditingController postContentController = TextEditingController();

  static Future<void> addPost(channelId, image) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString('token');
    try {
      final response = await dio.post(
        "http://petmily.duckdns.org/channel/$channelId/post/write",
        data: {
          "title": postTitleController.text,
          "content": postContentController.text,
          "imagePath": image.toString()
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
            'Content-Type': 'application/json'
          },
        ),
      );
      if (response.statusCode == 200) {
        final responseData = response.data;
        var resData = responseData;
        log('Post add Success : $resData');
      } else {
        log('Post add faile : ${response.statusCode}');
      }
    } catch (e) {
      log('Post add faile : $e');
    }
  }
}
