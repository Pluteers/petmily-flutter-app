import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

final dio = Dio();

class AddPost {
  static TextEditingController postTitleController = TextEditingController();
  static TextEditingController postContentController = TextEditingController();

  static Future<void> addPost(channelId) async {
    var accessToken =
        "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJBY2Nlc3NUb2tlbiIsImV4cCI6MTY4NDgxMjI1NiwiZW1haWwiOiJ0ZXN0NEBuYXZlci5jb20ifQ.pEG7RJAy4CK7go9keWwaYDGiIePZm613hp-CLLVA8NucH1QKYs_RWNAenQNf_Nmq4uQB9m8MIJIRet4bk21IHA";

    try {
      final response = await dio.post(
        "http://petmily.duckdns.org/channel/${channelId}/post/write",
        data: {
          "title": postTitleController.text,
          "content": postContentController.text,
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
//Header : {   Authorization: Bearer (Access Token필요) }

// {
// "title" :"우리 귀염둥이의 일상5",
// "content" :"귀염둥이의 일상을 보러 떠납시다4",

// }

// 나중에 이미지 경로,카테고리 아이디(이름) 추가예정s