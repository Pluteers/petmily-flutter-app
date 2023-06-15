import 'dart:developer';
import 'package:flutter/material.dart';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

final dio = Dio();

class GetPostData extends ChangeNotifier {
  static List<Data> _dataList = [];
  List<Data> post = [];
  List<Data> get data => _dataList;

  Future<List<Data>> getPost(channelId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString('token');
    var response =
        await dio.get(("http://petmily.duckdns.org/channel/$channelId/post"),
            options: Options(
              headers: {
                'Authorization': 'Bearer $accessToken',
              },
            ));
    log("접근채널 : $channelId");
    final responseData = response.data;
    log('postSuccess : $responseData');
    final getPostlModel = PostModel.fromJson(responseData);
    return getPostlModel.data!;
    // notifyListeners();
  }
}

class PostModel {
  String? success;
  String? message;
  String? channelName;
  List<Data>? data;

  PostModel({this.success, this.message, this.data});

  PostModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    channelName = json['channelName'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    data['channelName'] = channelName;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? createDate;
  String? lastModifiedDate;
  int? id;
  String? title;
  String? content;
  int? likePost;
  int? hit;
  String? imagePath;
  String? nickname;
  int? channelId;
  String? channelName;

  Data({
    this.createDate,
    this.lastModifiedDate,
    this.id,
    this.title,
    this.content,
    this.likePost,
    this.hit,
    this.imagePath,
    this.nickname,
    this.channelId,
    this.channelName,
  });

  Data.fromJson(Map<String, dynamic> json) {
    createDate = json['createDate'];
    lastModifiedDate = json['lastModifiedDate'];
    id = json['id'];
    title = json['title'];
    content = json['content'];
    likePost = json['likePost'];
    hit = json['hit'];
    imagePath = json['imagePath'];
    nickname = json['nickname'];
    channelId = json['channelId'];
    channelName = json['channelName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['createDate'] = createDate;
    data['lastModifiedDate'] = lastModifiedDate;
    data['id'] = id;
    data['title'] = title;
    data['content'] = content;
    data['likePost'] = likePost;
    data['hit'] = hit;
    data['imagePath'] = imagePath;
    data['nickname'] = nickname;
    data['channelId'] = channelId;
    data['channelName'] = channelName;
    return data;
  }
}
