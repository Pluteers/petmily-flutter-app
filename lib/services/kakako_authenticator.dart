import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

class KakaoAuthenticator {
  Future<bool> loginWithKakao() async {
    try {
      final bool installed = await isKakaoTalkInstalled();
      if (installed) {
        try {
          final request = await UserApi.instance.loginWithKakaoTalk();
          var oneOffToken = request.accessToken;
          await sendOneOffToken(oneOffToken);
          return true;
        } catch (e) {
          log("$e");
          return false;
        }
      } else if (!installed) {
        try {
          final request = await UserApi.instance.loginWithKakaoAccount();
          var oneOffToken = request.accessToken;
          await sendOneOffToken(oneOffToken);
          return true;
        } catch (e) {
          log("$e");
          return false;
        }
      }
    } catch (e) {
      log("$e");
      return false;
    }
    return false;
  }

  Future<String?> sendOneOffToken(String oneOffToken) async {
    try {
      final dio = Dio();
      final response = await dio.post(
        "http://petmily.duckdns.org/login/oauth2/code/kakao",
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $oneOffToken",
          },
        ),
      );
      if (response.statusCode == 200) {
        log("1.성공적으로 토큰을 보냈습니다.");
        var accessToken = jsonDecode(response.data)["accessToken"];
        log("서버에서 새로 가져온 토큰[$accessToken]");
        return accessToken;
      } else {
        log("토큰을 전송하는데 실패했습니다. 오류[${response.statusMessage}]");
      }
    } catch (e) {
      log("예기치 못한 오류가 발생했습니다. 오류[$e]");
    }
    return null;
  }
}
