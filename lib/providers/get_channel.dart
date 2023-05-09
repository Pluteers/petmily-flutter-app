import 'dart:developer';
import 'package:dio/dio.dart';

final dio = Dio();
Future<GetChannel> getChannel() async {
  var accessToken =
      "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJBY2Nlc3NUb2tlbiIsImV4cCI6MTY4NDgxMjI1NiwiZW1haWwiOiJ0ZXN0NEBuYXZlci5jb20ifQ.pEG7RJAy4CK7go9keWwaYDGiIePZm613hp-CLLVA8NucH1QKYs_RWNAenQNf_Nmq4uQB9m8MIJIRet4bk21IHA";

  var response = await dio.get(("http://petmily.duckdns.org/channel"),
      options: Options(
        headers: {
          'Authorization': 'Bearer ' + accessToken,
          'Content-Type': 'application/json'
        },
      ));

  final responseData = response.data;
  var resData = responseData;
  log('channelSuccess : $resData');

  final getChannelModel = GetChannel.fromJson(resData);
  return getChannelModel;
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
