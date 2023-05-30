import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

final dio = Dio();

class GetChannelData extends ChangeNotifier {
  static List<Data> _dataList = [];

  List<Data> get data => _dataList;

  void setData(List<Data> dataList) {
    _dataList = dataList;
    notifyListeners();
  }

  Future<void> getChannel() async {
    var accessToken =
        "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJBY2Nlc3NUb2tlbiIsImV4cCI6MTY4NjE5NDI0OCwiZW1haWwiOiJ0ZXN0MkBuYXZlci5jb20ifQ.wgfd8OpZcBmK2Wb983VXOe2otFqcPdEa0pkzqsX4ITV1yfDoqVq74pKh0ReCMSGSjCrtw5ejAfYDW8F1qRCCIA";

    try {
      final response = await dio.get(("http://petmily.duckdns.org/channel"),
          options: Options(
            headers: {
              'Authorization': 'Bearer $accessToken',
              'Content-Type': 'application/json'
            },
          ));
      if (response.statusCode == 200) {
        final responseData = response.data;
        final getChannelModel = GetChannel.fromJson(responseData);
        _dataList = getChannelModel.data!;
        notifyListeners();
        log('ChannelList Success');
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      log("ChannelList Get Error : $e");
    }
  }
}

class GetChannel {
  String? message;
  List<Data>? data;

  GetChannel({this.message, this.data});

  GetChannel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? channelId;
  String? channelName;
  String? categoryName;
  int? categoryId;

  Data({this.channelId, this.channelName, this.categoryName, this.categoryId});

  Data.fromJson(Map<String, dynamic> json) {
    channelId = json['channelId'];
    channelName = json['channelName'];
    categoryName = json['categoryName'];
    categoryId = json['categoryId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['channelId'] = this.channelId;
    data['channelName'] = this.channelName;
    data['categoryName'] = this.categoryName;
    data['categoryId'] = this.categoryId;
    return data;
  }
}
