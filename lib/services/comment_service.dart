import 'dart:developer';

import 'package:http/http.dart' as http;

void updateComment(int commentId, String accessToken, String content) async {
  final url = Uri.parse('http://petmily.duckdns.org/comment/$commentId/update');

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

void deleteComment(int commentId, String accessToken) async {
  final url = Uri.parse('http://petmily.duckdns.org/comment/$commentId/delete');

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

void likeComment(int commentId, String accessToken) async {
  final url = Uri.parse('http://petmily.duckdns.org/comment/$commentId/like');

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
