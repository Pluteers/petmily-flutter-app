import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

final dio = Dio();

class ChannelService {
  Future<void> deleteChannel(id) async {
    final url = "http://petmily.duckdns.org/channel/delete/$id";
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString('token');

    try {
      final response = await dio.delete(
        url,
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
            'Content-Type': 'application/json'
          },
        ),
      );

      if (response.statusCode == 200) {
        log('체널 삭제 성공.');
      } else {
        log('체널 삭제 실패. 에러 코드: ${response.statusCode}');
      }
    } catch (e) {
      log('체널 삭제 중 오류 발생: $e');
    }
  }
}
