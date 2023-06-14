import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:petmily/models/detail_post_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

final dio = Dio();

class DetailPostProvider extends ChangeNotifier {
  Future<Data?> getDetailPostProvider(channelId, postId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString('token');

    final response = await dio.get(
        ("http://petmily.duckdns.org/channel/$channelId/post/$postId"),
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
            'Content-Type': 'application/json'
          },
        ));

    final detailPostModel = DetailPostModel.fromJson(response.data);
    log('DetailPost Success : ${response.data}');
    return detailPostModel.data;
  }
}
