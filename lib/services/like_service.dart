import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

void addLikeChanel(String channelId) async {
  Dio dio = Dio();

  String baseUrl = 'http://petmily.duckdns.org/channel/';
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? accessToken = prefs.getString('token');

  String url = baseUrl + channelId + '/bookmark';

  Options options = Options(
    headers: {
      'Authorization': 'Bearer $accessToken',
    },
  );

  dio.post(url, options: options).then((response) {
    log('즐겨찾기 추가 성공');
  }).catchError((error) {
    log('오류 발생: $error');
  });
}

void deleteLikeChanel(String channelId) async {
  Dio dio = Dio();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? accessToken = prefs.getString('token');
  String baseUrl = 'http://petmily.duckdns.org/channel/';
  String url = baseUrl + channelId + '/bookmark';

  Options options = Options(
    headers: {
      'Authorization': 'Bearer $accessToken',
    },
  );

  dio.delete(url, options: options).then((response) {
    log('즐겨찾기 삭제 성공');
  }).catchError((error) {
    log('오류 발생: $error');
  });
}

void addScrap(String postId) async {
  Dio dio = Dio();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? accessToken = prefs.getString('token');

  String baseUrl = 'http://petmily.duckdns.org/post/';

  String url = baseUrl + postId + '/scrap';

  Options options = Options(
    headers: {
      'Authorization': 'Bearer $accessToken',
    },
  );

  dio.get(url, options: options).then((response) {
    log('스크랩 추가 성공');
  }).catchError((error) {
    log('오류 발생: $error');
  });
}

void cancelScrap(String scrapId) async {
  Dio dio = Dio();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? accessToken = prefs.getString('token');

  String baseUrl = 'http://petmily.duckdns.org/scrap/';

  String url = baseUrl + scrapId + '/cancel';

  Options options = Options(
    headers: {
      'Authorization': 'Bearer $accessToken',
    },
  );

  dio.post(url, options: options).then((response) {
    log('스크랩 취소 성공');
  }).catchError((error) {
    log('오류 발생: $error');
  });
}
