import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

final dio = Dio();

class GetChannelData extends ChangeNotifier {
  GetChannel? getChannelModel;

  Future<GetChannel?> getChannel() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString('token');

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
        getChannelModel = GetChannel.fromJson(responseData);

        notifyListeners();
        log('ChannelList Success');
        return getChannelModel;
      } else {
        return getChannelModel;
      }
    } catch (e) {
      log("ChannelList Get Error : $e");
      return getChannelModel;
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
