import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

final dio = Dio();

class GetCommentList {
  Future<void> getCommentList(postId) async {
    var accessToken =
        "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJBY2Nlc3NUb2tlbiIsImV4cCI6MTY4NjA0MjgzOSwiZW1haWwiOiJ0ZXN0NEBuYXZlci5jb20ifQ.svOFWFpDQvIT0XPqf4D5fvBFIqULVE5hL_LaaNl3bC1AQ103lz9xtCofr_kbufXMi7CbNtyPG9feEOTUTbLIsw";

    try {
      final response =
          await dio.get(("http://petmily.duckdns.org/post/$postId/comment"),
              options: Options(
                headers: {
                  'Authorization': 'Bearer $accessToken',
                  'Content-Type': 'application/json'
                },
              ));
      if (response.statusCode == 200) {
        final responseData = response.data;

        log('GetComment Success : $responseData');
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      log("ChannelList Get Error : $e");
    }
  }
}
