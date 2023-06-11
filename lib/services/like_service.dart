import 'dart:developer';

import 'package:dio/dio.dart';

void getLikeChanel() {
  Dio dio = Dio();
  String url = 'http://petmily.duckdns.org/bookmark';
  String accessToken = '';
  Options options = Options(
    headers: {
      'Authorization': 'Bearer $accessToken',
    },
  );

  dio.get(url, options: options).then((response) {
    log(response.data);
  }).catchError((error) {
    log('오류 발생: $error');
  });
}

void addLikeChanel() {
  Dio dio = Dio();

  String baseUrl = 'http://petmily.duckdns.org/channel/';
  String channelId = '';
  String url = baseUrl + channelId + '/bookmark';

  String accessToken = 'YOUR_ACCESS_TOKEN';
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

void deleteLikeChanel() {
  Dio dio = Dio();
  String baseUrl = 'http://petmily.duckdns.org/channel/';
  String channelId = '';
  String url = baseUrl + channelId + '/bookmark';

  String accessToken = 'YOUR_ACCESS_TOKEN';
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

void addScrap() {
  Dio dio = Dio();

  String baseUrl = 'http://petmily.duckdns.org/post/';
  String postId = 'YOUR_POST_ID';
  String url = baseUrl + postId + '/scrap';

  String accessToken = 'YOUR_ACCESS_TOKEN';
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

void main() {
  Dio dio = Dio();

  String baseUrl = 'http://petmily.duckdns.org/scrap/';
  String scrapId = 'YOUR_SCRAP_ID';
  String url = baseUrl + scrapId + '/cancel';

  String accessToken = 'YOUR_ACCESS_TOKEN';
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
