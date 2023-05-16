import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

final dio = Dio();

class DetailPostProvider extends ChangeNotifier {
  Future<Data?> getDetailPostProvider(channelId, postId) async {
    var accessToken =
        "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJBY2Nlc3NUb2tlbiIsImV4cCI6MTY4NDgxMjI1NiwiZW1haWwiOiJ0ZXN0NEBuYXZlci5jb20ifQ.pEG7RJAy4CK7go9keWwaYDGiIePZm613hp-CLLVA8NucH1QKYs_RWNAenQNf_Nmq4uQB9m8MIJIRet4bk21IHA";

    final response = await dio.get(
        ("http://petmily.duckdns.org/channel/$channelId/post/$postId"),
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
            'Content-Type': 'application/json'
          },
        ));

    final detailPostModel = DetailPostModel.fromJson(response.data);
    log('DetailPost Success : ${response.data}');
    return detailPostModel.data;
  }
}

class DetailPostModel {
  String? success;
  String? message;
  String? channelName;
  String? channelCreaterName;
  Data? data;

  DetailPostModel(
      {this.success,
      this.message,
      this.channelName,
      this.channelCreaterName,
      this.data});

  DetailPostModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    channelName = json['channelName'];
    channelCreaterName = json['channelCreaterName'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['channelName'] = this.channelName;
    data['channelCreaterName'] = this.channelCreaterName;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
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
  int? memberId;
  String? nickname;
  int? channelId;
  String? channelName;

  Data(
      {this.createDate,
      this.lastModifiedDate,
      this.id,
      this.title,
      this.content,
      this.likePost,
      this.hit,
      this.imagePath,
      this.memberId,
      this.nickname,
      this.channelId,
      this.channelName});

  Data.fromJson(Map<String, dynamic> json) {
    createDate = json['createDate'];
    lastModifiedDate = json['lastModifiedDate'];
    id = json['id'];
    title = json['title'];
    content = json['content'];
    likePost = json['likePost'];
    hit = json['hit'];
    imagePath = json['imagePath'];
    memberId = json['memberId'];
    nickname = json['nickname'];
    channelId = json['channelId'];
    channelName = json['channelName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createDate'] = this.createDate;
    data['lastModifiedDate'] = this.lastModifiedDate;
    data['id'] = this.id;
    data['title'] = this.title;
    data['content'] = this.content;
    data['likePost'] = this.likePost;
    data['hit'] = this.hit;
    data['imagePath'] = this.imagePath;
    data['memberId'] = this.memberId;
    data['nickname'] = this.nickname;
    data['channelId'] = this.channelId;
    data['channelName'] = this.channelName;
    return data;
  }
}
