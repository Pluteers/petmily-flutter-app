import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

final dio = Dio();

class CommentService {
  TextEditingController addCommentContent = TextEditingController();
  void addComment(int postId) async {
    final url = 'http://petmily.duckdns.org/post/$postId/comment/add';
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString('token');

    try {
      final response = await dio.post(url,
          options: Options(
            headers: {
              'Authorization': 'Bearer $accessToken',
              'Content-Type': 'application/json'
            },
          ),
          data: {
            "content": addCommentContent.text,
          });

      if (response.statusCode == 200) {
        log('댓글 등록 성공.');
      } else {
        log('댓글 등록 실패. 에러 코드: ${response.statusCode}');
      }
    } catch (e) {
      log('댓글 등록 중 오류 발생: $e');
    }
  }

  void updateComment(int commentId, String content) async {
    final url =
        Uri.parse('http://petmily.duckdns.org/comment/$commentId/update');
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString('token');

    final headers = {'Authorization': 'Bearer $accessToken'};

    final body = {'content': content};

    try {
      final response = await http.put(
        url,
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        log('댓글 수정 성공.');
      } else {
        log('댓글 수정 실패. 에러 코드: ${response.statusCode}');
      }
    } catch (e) {
      log('댓글 수정 중 오류 발생: $e');
    }
  }

  void deleteComment(int commentId) async {
    final url =
        Uri.parse('http://petmily.duckdns.org/comment/$commentId/delete');
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString('token');

    final headers = {'Authorization': 'Bearer $accessToken'};

    try {
      final response = await http.delete(
        url,
        headers: headers,
      );

      if (response.statusCode == 200) {
        log('댓글 삭제 성공.');
      } else {
        log('댓글 삭제 실패. 에러 코드: ${response.statusCode}');
      }
    } catch (e) {
      log('댓글 삭제 중 오류 발생: $e');
    }
  }

  void likeComment(int commentId) async {
    final url = Uri.parse('http://petmily.duckdns.org/comment/$commentId/like');
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString('token');

    final headers = {'Authorization': 'Bearer $accessToken'};

    try {
      final response = await http.post(
        url,
        headers: headers,
      );

      if (response.statusCode == 200) {
        log('좋아요 처리 성공');
      } else {
        log('좋아요 처리에 실패. 에러 코드: ${response.statusCode}');
      }
    } catch (e) {
      log('좋아요 처리 중 오류가 발생: $e');
    }
  }
}
