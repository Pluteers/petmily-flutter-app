import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:petmily/models/scrap_model.dart';

import 'package:shared_preferences/shared_preferences.dart';

final dio = Dio();

class ScrapService {
  //http://petmily.duckdns.org/scrap/list
  Future<ScrapListModel?> userScrapList() async {
    const url = "http://petmily.duckdns.org/scrap/list";
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString('token');
    ScrapListModel? scrapModel;
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

        log('ScrapList Success : $responseData');
        final userScrapData = ScrapListModel.fromJson(responseData);
        scrapModel = userScrapData;
        return scrapModel;
      } else {
        log("${response.statusCode}");
        return scrapModel;
      }
    } catch (e) {
      log("$e");
      return scrapModel;
    }
  }

  Future<void> addScrap(postId) async {
    var url = "http://petmily.duckdns.org/post/$postId/scrap";
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString('token');

    try {
      final response = await dio.post((url),
          options: Options(
            headers: {
              'Authorization': 'Bearer $accessToken',
              'Content-Type': 'application/json'
            },
          ));
      if (response.statusCode == 200) {
        final responseData = response.data;

        log('Scrap add Success : $responseData');
      } else {
        log("${response.statusCode}");
      }
    } catch (e) {
      log("$e");
    }
  }

  Future<void> deleteScrap(postId) async {
    var url = "http://petmily.duckdns.org/post/$postId/scrap";
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString('token');

    try {
      final response = await dio.delete((url),
          options: Options(
            headers: {
              'Authorization': 'Bearer $accessToken',
              'Content-Type': 'application/json'
            },
          ));
      if (response.statusCode == 200) {
        final responseData = response.data;

        log('Scrap add Success : $responseData');
      } else {
        log("${response.statusCode}");
      }
    } catch (e) {
      log("$e");
    }
  }
}
