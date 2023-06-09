import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';

import 'package:dio/dio.dart';
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
        final responseData = jsonDecode(response.data);
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
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
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
    channelId = json['channelId'] as int?;
    channelName = json['channelName'] as String?;
    categoryName = json['categoryName'] as String?;
    categoryId = json['categoryId'] as int?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['channelId'] = channelId;
    data['channelName'] = channelName;
    data['categoryName'] = categoryName;
    data['categoryId'] = categoryId;
    return data;
  }
}
