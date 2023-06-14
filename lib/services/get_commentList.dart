import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:petmily/models/commentList_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

final dio = Dio();

class GetCommentList {
  Future<CommentListModel?> getCommentList(postId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString('token');
    CommentListModel? commentListModel;

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

      commentListModel = CommentListModel.fromJson(responseData);
      // final getCommentList = commentsList(responseData);

      return commentListModel;
    } else {
      return commentListModel;
    }
  }
}
