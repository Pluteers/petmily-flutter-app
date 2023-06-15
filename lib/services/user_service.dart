import 'dart:developer';
import 'package:flutter/material.dart';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:petmily/models/my_channel_model.dart';
import 'package:petmily/models/my_comment_model.dart';
import 'package:petmily/models/my_page_model.dart';
import 'package:petmily/models/my_post_model.dart';

final dio = Dio();

class UserService {
  Future<MyPageModel?> userInfo() async {
    const url = "http://petmily.duckdns.org/user/info";
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString("token");
    MyPageModel? dataList;
    try {
      final response = await dio.get((url),
          options: Options(
            headers: {
              "Authorization": "Bearer $accessToken",
              "Content-Type": "application/json"
            },
          ));
      if (response.statusCode == 200) {
        final responseData = response.data;

        log("userInfo Success : $responseData");

        final mypageData = MyPageModel.fromJson(responseData);
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
    final String? accessToken = prefs.getString("token");

    try {
      final response = await dio.patch((url),
          options: Options(
            headers: {
              "Authorization": "Bearer $accessToken",
            },
          ),
          data: {
            "email": editEmailController.text,
            "nickname": editNicknameController.text,
            "password": editPasswordController.text
          });
      if (response.statusCode == 200) {
        final responseData = response.data;

        log("Edit Info Success : $responseData");
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

  Future<MyChannelModel?> myChannel() async {
    const url = "http://petmily.duckdns.org/channel/mypage";
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString("token");
    MyChannelModel? myChannelModel;

    try {
      final response = await dio.get(
        (url),
        options: Options(
          headers: {
            "Authorization": "Bearer $accessToken",
          },
        ),
      );
      if (response.statusCode == 200) {
        final responseData = response.data;

        log("Get MyChannels Success : $responseData");
        final myPageChannelData = MyChannelModel.fromJson(responseData);
        myChannelModel = myPageChannelData;
        return myChannelModel;
      } else {
        log("${response.statusCode}");
        return myChannelModel;
      }
    } catch (e) {
      log("$e");
      return myChannelModel;
    }
  }

  Future<MyPostModel?> myPost() async {
    const url = "http://petmily.duckdns.org/post/mypage";
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString("token");
    MyPostModel? myPostModel;

    try {
      final response = await dio.get(
        (url),
        options: Options(
          headers: {
            "Authorization": "Bearer $accessToken",
          },
        ),
      );
      if (response.statusCode == 200) {
        final responseData = response.data;

        log("Get MyPost Success : $responseData");
        myPostModel = MyPostModel.fromJson(responseData);
        return myPostModel;
      } else {
        log("${response.statusCode}");
        return myPostModel;
      }
    } catch (e) {
      log("$e");
      return myPostModel;
    }
  }

  Future<MyCommentModel?> myComment() async {
    const url = "http://petmily.duckdns.org/comment/mycomment";
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString("token");
    MyCommentModel? myCommentModel;

    try {
      final response = await dio.get(
        (url),
        options: Options(
          headers: {
            "Authorization": "Bearer $accessToken",
          },
        ),
      );
      if (response.statusCode == 200) {
        final responseData = response.data;

        log("Get MyComments Success : $responseData");
        myCommentModel = MyCommentModel.fromJson(responseData);
        return myCommentModel;
      } else {
        log("${response.statusCode}");
        return myCommentModel;
      }
    } catch (e) {
      log("$e");
      return myCommentModel;
    }
  }
}
