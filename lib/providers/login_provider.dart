import 'dart:developer';
import 'package:flutter/foundation.dart';
/**
 * import 'package:shared_preferences/shared_preferences.dart';
 * 나중에 사용자 정보를 저장하고, 앱을 재실행해도 자동 로그인이 되도록 해야합니다.
 * */
import 'package:petmily/services/kakako_authenticator.dart';
import 'package:petmily/services/local_authenticator.dart';

///로컬 로그인 인증 상태를 열거형으로 구분합니다.
enum LoginStatus {
  success,
  failed,
  loading,
  idle,
}

///- `localLogin()`: Petmily 로컬 계정으로 로그인을 수행하는 메소드입니다.
///   - [email, password]가 필요합니다.
///- `kakaoLogin()`: 카카오 소셜 로그인 처리를 담당하는 비동기 함수입니다.
class LoginProvider extends ChangeNotifier {
  LocalAuthenticator localAuthenticator = LocalAuthenticator();
  LoginStatus loginStatus = LoginStatus.idle;

  ///- 로그인 진행 상태를 변경하는 메소드입니다.
  void setStatus(LoginStatus newState) {
    loginStatus = newState;
    notifyListeners();
  }

  ///Petmily 로컬 로그인 처리를 담당하는 비동기 함수입니다.
  Future<void> localLogin(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      setStatus(LoginStatus.failed);
      notifyListeners();
    }

    setStatus(LoginStatus.loading);
    notifyListeners();

    try {
      await localAuthenticator.signIn(email: email, password: password);
      setStatus(LoginStatus.success);
      notifyListeners();
    } catch (e) {
      setStatus(LoginStatus.failed);
      log("$e");
    } finally {
      notifyListeners();
    }
  }

  ///카카오 소셜 로그인 처리를 담당하는 비동기 함수입니다.
  Future<void> kakaoLogin() async {
    setStatus(LoginStatus.loading);
    final isSuccess = await KakaoAuthenticator().loginWithKakao();
    if (isSuccess) {
      setStatus(LoginStatus.success);
      notifyListeners();
    } else if (!isSuccess) {
      setStatus(LoginStatus.failed);
      notifyListeners();
    }
  }
}
