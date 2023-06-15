import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

final dio = Dio();

class PostLikeService {
  Future<void> postLike(channelId, postId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString("token");

    var response = await dio.post(
      "http://petmily.duckdns.org/channel/$channelId/post/$postId/like",
      options: Options(
        headers: {
          "Authorization": "Bearer $accessToken",
        },
      ),
    );

    final responseData = response;
    var resData = responseData;
    log("LikePostSuccess : $resData");
  }
}
