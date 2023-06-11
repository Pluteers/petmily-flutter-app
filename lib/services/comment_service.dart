import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

final dio = Dio();

void updateComment(int commentId, String content) async {
  final url = 'http://petmily.duckdns.org/comment/$commentId/update';
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? accessToken = prefs.getString('token');
  final headers = {'Authorization': 'Bearer $accessToken'};

  try {
    final response = await dio.put(
      url,
      options: Options(headers: headers, contentType: content),
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
  final url = 'http://petmily.duckdns.org/comment/$commentId/delete';
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? accessToken = prefs.getString('token');
  final headers = {'Authorization': 'Bearer $accessToken'};

  try {
    final response = await dio.delete(
      url,
      options: Options(headers: headers),
    );

    if (response.statusCode == 200) {
      log('댓글 삭제 성공.');
    } else {
      log('댓글 삭제 실패. 에러 코드: ${response.statusCode}');
    }
  } catch (e) {
    if (e is DioError) {
      final response = e.response;

      if (response?.statusCode == 400) {
        log("400Error");
      } else {
        log("Network Error");
      }
    } else {
      log("$e");
    }
    log('댓글 삭제 중 오류 발생 : $e');
  }
}

void likeComment(int commentId) async {
  final url = 'http://petmily.duckdns.org/comment/$commentId/like';
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? accessToken = prefs.getString('token');
  final headers = {'Authorization': 'Bearer $accessToken'};

  try {
    final response = await dio.post(
      url,
      options: Options(headers: headers),
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
