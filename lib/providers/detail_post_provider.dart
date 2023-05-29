import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:petmily/models/detail_post_model.dart';

final dio = Dio();

class DetailPostProvider extends ChangeNotifier {
  Future<Data?> getDetailPostProvider(channelId, postId) async {
    var accessToken =
        "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJBY2Nlc3NUb2tlbiIsImV4cCI6MTY4NjA0MjgzOSwiZW1haWwiOiJ0ZXN0NEBuYXZlci5jb20ifQ.svOFWFpDQvIT0XPqf4D5fvBFIqULVE5hL_LaaNl3bC1AQ103lz9xtCofr_kbufXMi7CbNtyPG9feEOTUTbLIsw";

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
