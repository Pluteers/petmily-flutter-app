import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:petmily/models/mypage.dart';
import 'package:shared_preferences/shared_preferences.dart';

final dio = Dio();

class UserService {
  Future<MyPageData?> userInfo() async {
    const url = "http://petmily.duckdns.org/user/info";
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString('token');
    MyPageData? dataList;
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

        log('userInfo Success : $responseData');

        final mypageData = MyPageData.fromJson(responseData);
        dataList = mypageData;
        return dataList;
      } else {
        log("${response.statusCode}");

        return dataList;
      }
    } catch (e) {
      log("$e");
      return dataList;
    }
  }

  TextEditingController editEmailController = TextEditingController();
  TextEditingController editNicknameController = TextEditingController();
  TextEditingController editPasswordController = TextEditingController();
  void editUserInfo({
    required Function() onSuccess,
    required Function(String err) onError,
  }) async {
    const url = "http://petmily.duckdns.org/user/update";
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString('token');

    try {
      final response = await dio.patch((url),
          options: Options(
            headers: {
              'Authorization': 'Bearer $accessToken',
            },
          ),
          data: {
            "email": editEmailController.text,
            "nickname": editNicknameController.text,
            "password": editPasswordController.text
          });
      if (response.statusCode == 200) {
        final responseData = response.data;

        log('Edit Info Success : $responseData');
        onSuccess();
      } else {
        log("${response.statusCode}");
        onError("${response.statusCode}");
      }
    } catch (e) {
      log("$e");
      onError("$e");
    }
  }
}
