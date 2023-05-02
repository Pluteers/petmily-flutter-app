import 'dart:developer';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

class KakaoAuthenticator {
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
