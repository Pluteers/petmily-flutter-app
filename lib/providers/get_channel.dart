import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

Future<GetChannel> getChannel() async {
  var accessToken =
      "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJBY2Nlc3NUb2tlbiIsImV4cCI6MTY4MzUyMzc4OSwiZW1haWwiOiJ0ZXN0MkBuYXZlci5jb20ifQ.e0UPecdFW4OuyxAgmvuazRUL1hYHW9FdtaVAUp5VoOXt7rC-HIbS91ARwNixoCVniO7sjx3xKtUH4GCbfiL5TQ";
  var response = await http.get(
    Uri.parse("http://petmily.duckdns.org/post/channel"),
    headers: {
      "Authorization": "Bearer " + accessToken,
    },
  );
  //eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJBY2Nlc3NUb2tlbiIsImV4cCI6MTY4MzUxOTUxMSwiZW1haWwiOiJ0ZXN0NEBuYXZlci5jb20ifQ.RVKa1_gtl_jMmQu6oHuiM7Fna8AxmnGFiKx8eTYLwMVmHSYnjA5NgtK9VRhUmWcVqhfT15dlEUpVgDL-20nSdQ

  final responseData = json.decode(utf8.decode(response.bodyBytes));
  var resData = responseData;
  log('channelSuccess : $resData');

  return GetChannel.fromJson(responseData);
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
