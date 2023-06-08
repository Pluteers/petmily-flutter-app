import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:petmily/models/favorite_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

final dio = Dio();

class FavoriteService {
  // http://petmily.duckdns.org/bookmark
  Future<FavoriteListModel?> userFavoriteList() async {
    const url = "http://petmily.duckdns.org/bookmark";
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString('token');
    FavoriteListModel? favoriteListModel;

    try {
      final response = await dio.get((url),
          options: Options(
            headers: {
              'Authorization': 'Bearer $accessToken',
              'Content-Type': 'application/json'
            },
          ));
      if (response.statusCode == 200) {
        final responseData = response.data;

        log('FavoriteList Success : $responseData');
        final favoriteListData = FavoriteListModel.fromJson(responseData);
        favoriteListModel = favoriteListData;
        return favoriteListModel;
      } else {
        log("${response.statusCode}");
        return favoriteListModel;
      }
    } catch (e) {
      log("$e");
      return favoriteListModel;
    }
  }
}
