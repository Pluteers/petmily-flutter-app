import 'dart:developer';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:petmily/utilities/constants.dart';

class KakaoAuthenticator {
  String get kakao => Constants.kakao;

  Future<bool> login() async {
    try {
      bool isInstalled = await isKakaoTalkInstalled();
      if (isInstalled) {
        try {
          OAuthToken token = await UserApi.instance.loginWithKakaoTalk();
          log("$token");
          return true;
        } catch (e) {
          log("$e");
          return false;
        }
      } else if (!isInstalled) {
        try {
          OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
          log("$token");
          return true;
        } catch (e) {
          log("$e");
          return false;
        }
      }
      return true;
    } catch (e) {
      log("$e");
      return false;
    }
  }
}
