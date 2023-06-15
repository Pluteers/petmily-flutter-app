import 'dart:developer';
import 'package:flutter/material.dart';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

final dio = Dio();

class PostService {
  TextEditingController editTitle = TextEditingController();
  TextEditingController editContent = TextEditingController();
  void editPost(int channelId, int id) async {
    final url = "http://petmily.duckdns.org/channel/$channelId/post/update/$id";
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString("token");

    try {
      final response = await dio.put(url,
          options: Options(
            headers: {
              "Authorization": "Bearer $accessToken",
              "Content-Type": "application/json"
            },
          ),
          data: {
            {
              "title": editTitle.text,
              "content": editContent.text,
            }
          });

      if (response.statusCode == 200) {
        log("게시글 수정 성공.");
      } else {
        log("게시글 수정 실패. 에러 코드: ${response.statusCode}");
      }
    } catch (e) {
      log("게시글 수정 중 오류 발생: $e");
    }
  }

  void deletePost(int channelId, int id) async {
    final url = "http://petmily.duckdns.org/channel/$channelId/post/delete/$id";
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString("token");

    try {
      final response = await dio.delete(
        url,
        options: Options(
          headers: {
            "Authorization": "Bearer $accessToken",
            "Content-Type": "application/json"
          },
        ),
      );

      if (response.statusCode == 200) {
        log("게시글 삭제 성공.");
      } else {
        log("게시글 삭제 실패. 에러 코드: ${response.statusCode}");
      }
    } catch (e) {
      log("게시글 삭제 중 오류 발생: $e");
    }
  }
}
