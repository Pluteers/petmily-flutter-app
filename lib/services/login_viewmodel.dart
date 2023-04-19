import 'package:flutter/foundation.dart';

class LoginViewModel extends ChangeNotifier {
  String email = '';
  String password = '';

  bool get isLoginDataValid => email.isNotEmpty && password.isNotEmpty;

  void setEmail(String newEmail) {
    email = newEmail;
    notifyListeners();
  }

  void setPassword(String newPassword) {
    password = newPassword;
    notifyListeners();
  }

  Future<bool> login() async {
    // 로그인 프로세스를 수행합니다. (API 호출 등)
    // 예시를 위해 email과 password가 일치하면 성공으로 가정합니다.
    return email == 'test' && password == '123';
  }
}
