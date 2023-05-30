import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier {
  final dio = Dio();

  void signUp({
    required String email,
    required String password,
    required String nickname,
    required Function() onSuccess,
    required Function(String err) onError,
  }) async {
    final url = 'http://petmily.duckdns.org/sign-up';
    final response = await dio.post(url, data: {
      'email': email,
      'nickname': nickname,
      'password': password,
    });

    if (email.isEmpty) {
      onError("이메일을 입력해 주세요.");
      return;
    } else if (password.isEmpty) {
      onError("비밀번호를 입력해 주세요.");
      return;
    }
    if (response.statusCode == 200) {
      onSuccess();
    } else {
      onError("회원가입에 실패했습니다.");
      log(response.statusCode.toString());
    }
  }

  void signIn({
    required String email,
    required String password,
    required Function() onSuccess,
    required Function(String err) onError,
  }) async {
    if (email.isEmpty) {
      onError('이메일을 입력해주세요.');
      return;
    } else if (password.isEmpty) {
      onError('비밀번호를 입력해주세요.');
      return;
    }

    var headers = {'Content-Type': 'application/json'};
    var request =
        http.Request('POST', Uri.parse('http://petmily.duckdns.org/login'));
    request.body =
        json.encode({"email": "test2@naver.com", "password": "test123"});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      log(await response.stream.bytesToString());
    } else {
      log(response.reasonPhrase!);
    }

    // 로그인 시도
    // final url = 'http://petmily.duckdns.org/login';
    // final response = await dio.post(url, data: {
    //   'email': email,
    //   'password': password,
    // });
    // onSuccess();

    //   final url = 'http://petmily.duckdns.org/login';
    //   final response = await http.post(Uri.parse(url), headers: {
    //     "Content-Type": "application/json"
    //   }, body: {
    //     'email': email,
    //     'password': password,
    //   });

    //   if (response.statusCode == 200) {
    //     final responseData = jsonDecode(response.body);
    //     final token = responseData['Authorization'];

    //     final prefs = await SharedPreferences.getInstance();
    //     await prefs.setString('token', token);
    //     String? check = prefs.getString('token');
    //     //log('prefs에 저장된 토큰: $check');
    //     debugPrint('prefs에 저장된 토큰 : $check');

    //     onSuccess();
    //   } else {
    //     onError('로그인에 실패했습니다.');
    //     debugPrint('else ${response.statusCode}');
    //   }
  }
}
