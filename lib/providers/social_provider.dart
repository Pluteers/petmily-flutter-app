import 'package:flutter/material.dart';
import 'package:petmily/services/kakako_authenticator.dart';

enum AuthenticateState {
  idle,
  loading,
  success,
  error,
}

class SocialProvider with ChangeNotifier {
  AuthenticateState authenticateState = AuthenticateState.idle;
  AuthenticateState get state => authenticateState;

  void setState(AuthenticateState newState) {
    authenticateState = newState;
    notifyListeners();
  }

  Future<void> login() async {
    setState(AuthenticateState.loading);
    bool result = await KakaoAuthenticator().login();

    if (result == true) {
      setState(AuthenticateState.success);
      notifyListeners();
    } else {
      setState(AuthenticateState.error);
      notifyListeners();
    }
  }
}
