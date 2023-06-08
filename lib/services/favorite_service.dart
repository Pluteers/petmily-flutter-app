import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

final dio = Dio();

class FavoriteService {
  // http://petmily.duckdns.org/bookmark
  Future<void> userFavoriteList() async {
    const url = "http://petmily.duckdns.org/bookmark";
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString('token');

    try {
      final response = await dio.get((url),
          options: Options(
            headers: {
              'Authorization': 'Bearer $accessToken',
              'Content-Type': 'application/json'
            },
          ));
      if (response.statusCode == 200) {
        final responseData = response.data;

        log('FavoriteList Success : $responseData');
      } else {
        log("${response.statusCode}");
      }
    } catch (e) {
      log("$e");
    }
  }
}
