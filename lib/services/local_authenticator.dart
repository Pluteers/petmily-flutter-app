import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:petmily/utilities/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalAuthenticator {
  final domain = Constants.domain;
  final local = Dio();

  void signUp({
    required String email,
    required String nickname,
    required String password,
  }) async {
    try {
      final response = await local.post(domain + Constants.signup, data: {
        "email": email,
        "nickname": nickname,
        "password": password,
      });

      if (response.statusCode == 200) {
        log("회원가입을 정상적으로 완료했습니다.");
      } else {
        log("${response.statusMessage}");
      }
    } catch (e) {
      log("$e");
    }
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      final response = await local.post(domain + Constants.signin, data: {
        "email": email,
        "password": password,
      });

      if (response.statusCode == 200) {
        final token = response.data["Authorization"];
        await prefs.setString('token', token);
        log("로그인에 성공했습니다.");
      } else {
        log("${response.statusMessage}");
      }
    } catch (e) {
      log("$e");
    }
  }
}
