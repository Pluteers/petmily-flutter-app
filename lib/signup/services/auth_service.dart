import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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

    // 로그인 시도
    const url = 'http://petmily.duckdns.org/login';
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await dio.post(url, data: {
      'email': email,
      'password': password,
    });
    try {
      if (response.statusCode == 200) {
        onSuccess();
        final token = response.data["Authorization"];

        await prefs.setString('token', token);
        log('set Token String : ${prefs.getString('token')!}');
        log('login success : $response');
      } else {
        log("login Error");
      }
    } catch (e) {
      log("$e");
    }
  }
}
