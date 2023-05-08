import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PostChannel {
  static TextEditingController channelTitleController = TextEditingController();

  static Future<void> postChannel(category) async {
    var accessToken =
        "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJBY2Nlc3NUb2tlbiIsImV4cCI6MTY4MzUyNzQyMSwiZW1haWwiOiJ0ZXN0MkBuYXZlci5jb20ifQ.tc902bfif5Gq_xXpSFQ6wBpPw1uSAx_7-TXztHk5puziBEi6vDJvYmFd1kiD5Maj8zC7_tOEa968vNRPkZ8JCQ";
    var response = await http.post(
        Uri.parse("http://petmily.duckdns.org/post/channel"),
        headers: {
          "Authorization": "Bearer " + accessToken,
          "Content-Type": "application/json",
        },
        body: jsonEncode(
            {"channelName": channelTitleController.text, "categoryId": "1"}));
    //eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJBY2Nlc3NUb2tlbiIsImV4cCI6MTY4MzUxOTUxMSwiZW1haWwiOiJ0ZXN0NEBuYXZlci5jb20ifQ.RVKa1_gtl_jMmQu6oHuiM7Fna8AxmnGFiKx8eTYLwMVmHSYnjA5NgtK9VRhUmWcVqhfT15dlEUpVgDL-20nSdQ

    final responseData = json.decode(utf8.decode(response.bodyBytes));
    var resData = responseData;
    log('channelPostSuccess : $resData');
  }
}



//Header : {   Authorization: Bearer (Access Token필요) }

// {
// "channelName" :"짱이의 일상2",
// "categoryId": "1"
// }