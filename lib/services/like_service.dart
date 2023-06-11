import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

void addLikeChanel() async {
  Dio dio = Dio();

  String baseUrl = 'http://petmily.duckdns.org/channel/';
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? accessToken = prefs.getString('token');

  String channelId = '';
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

void deleteLikeChanel() async {
  Dio dio = Dio();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? accessToken = prefs.getString('token');
  String baseUrl = 'http://petmily.duckdns.org/channel/';
  String channelId = '';
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

void addScrap() async {
  Dio dio = Dio();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? accessToken = prefs.getString('token');

  String baseUrl = 'http://petmily.duckdns.org/post/';
  String postId = 'YOUR_POST_ID';
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

void cancelScrap() async {
  Dio dio = Dio();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? accessToken = prefs.getString('token');

  String baseUrl = 'http://petmily.duckdns.org/scrap/';
  String scrapId = 'YOUR_SCRAP_ID';
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
