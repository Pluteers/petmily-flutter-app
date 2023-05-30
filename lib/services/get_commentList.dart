import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:petmily/models/commentList_model.dart';

final dio = Dio();

class GetCommentList {
  static Future<List<CommentListModel>> getCommentList(postId) async {
    var accessToken =
        "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJBY2Nlc3NUb2tlbiIsImV4cCI6MTY4NjA0MjgzOSwiZW1haWwiOiJ0ZXN0NEBuYXZlci5jb20ifQ.svOFWFpDQvIT0XPqf4D5fvBFIqULVE5hL_LaaNl3bC1AQ103lz9xtCofr_kbufXMi7CbNtyPG9feEOTUTbLIsw";

    final response =
        await dio.get(("http://petmily.duckdns.org/post/$postId/comment"),
            options: Options(
              headers: {
                'Authorization': 'Bearer $accessToken',
                'Content-Type': 'application/json'
              },
            ));
    if (response.statusCode == 200) {
      final responseData = jsonEncode(response.data);

      log('GetComment Success : $responseData');

      // final getCommentList = CommentListModel.fromJson(responseData);
      final getCommentList = CommentsList(responseData);

      return getCommentList;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
