import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

final dio = Dio();

class GetPostData extends ChangeNotifier {
  static List<Data> _dataList = [];
  List<Data> _post = [];

  List<Data> get data => _dataList;

  Future<List<Data>> getPost(channelId) async {
    var accessToken =
        "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJBY2Nlc3NUb2tlbiIsImV4cCI6MTY4NjA0MjgzOSwiZW1haWwiOiJ0ZXN0NEBuYXZlci5jb20ifQ.svOFWFpDQvIT0XPqf4D5fvBFIqULVE5hL_LaaNl3bC1AQ103lz9xtCofr_kbufXMi7CbNtyPG9feEOTUTbLIsw";
    var response =
        await dio.get(("http://petmily.duckdns.org/channel/$channelId/post"),
            options: Options(headers: {
              'Authorization': 'Bearer $accessToken',
            }));
    log("접근채널 : $channelId");
    final responseData = response.data;
    log('postSuccess : $responseData');
    // final getPostlModel = PostModel.fromJson(responseData);
    final getPostlModel = PostModel.fromJson(responseData);

    return getPostlModel.data!;

    _dataList = getPostlModel.data!;
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
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['channelName'] = this.channelName;
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

  Data(
      {this.createDate,
      this.lastModifiedDate,
      this.id,
      this.title,
      this.content,
      this.likePost,
      this.hit,
      this.imagePath,
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
    data['nickname'] = this.nickname;
    data['channelId'] = this.channelId;
    data['channelName'] = this.channelName;
    return data;
  }
}
