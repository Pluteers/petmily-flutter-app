import 'dart:developer';
import 'package:flutter/material.dart';

import 'package:dio/dio.dart';

import 'package:shared_preferences/shared_preferences.dart';

class AuthService extends ChangeNotifier {
  final dio = Dio();

  void signUp({
    required String email,
    required String password,
    required String nickname,
    required Function() onSuccess,
    required Function(String err) onError,
  }) async {
    const url = 'http://petmily.duckdns.org/sign-up';
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

    // 로그인 시도
    const url = 'http://petmily.duckdns.org/login';
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      final response = await dio.post(url, data: {
        'email': email,
        'password': password,
      });
      if (response.statusCode == 200) {
        final token = response.data["Authorization"];
        await prefs.setString('token', token);
        log('set Token String : ${prefs.getString('token')!}');
        log('login success : $response');
        onSuccess();
      }
    } catch (e) {
      if (e is DioException) {
        final response = e.response;
        if (response?.statusCode == 400) {
          onError("아이디 또는 비밀번호를 확인해주세요");
          log("400Error");
        } else {
          onError("네트워크 에러");
          log("Network Error : $e");
        }
      } else {
        log("$e");
        onError("오류 발생");
      }
    }
  }

  void signOut() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }
}
