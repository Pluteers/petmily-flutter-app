import 'package:flutter/foundation.dart';

enum LocalStatus { loading, canceled, error, success, idle }

class LocalAuthenticator extends ChangeNotifier {
  @protected
  String _email = "";
  @protected
  String _password = "";
  @protected
  String _errorMessage = "";
  @protected
  LocalStatus _localStatus = LocalStatus.idle;

  String get email => _email;
  String get password => _password;
  String get errorMessage => _errorMessage;
  LocalStatus get localStatus => _localStatus;

  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  void setPassword(String password) {
    _password = password;
    notifyListeners();
  }

  void signIn() {
    _localStatus = LocalStatus.loading;
    try {
      //TODO: 로컬 로그인 로직을 여기에 추가해야 해요.
      _localStatus = LocalStatus.success;
      notifyListeners();
    } catch (e) {
      _localStatus = LocalStatus.error;
      _errorMessage = "접속에 실패했습니다. 이메일과 비밀번호를 확인하시고 다시 시도해주세요.";
      _localStatus = LocalStatus.loading;
      notifyListeners();
    }
  }

  void signUp() {
    _localStatus = LocalStatus.loading;
    try {
      //TODO: 로컬 회원가입 로직을 여기에 추가해야 해요.
      _localStatus = LocalStatus.success;
      notifyListeners();
    } catch (e) {
      _localStatus = LocalStatus.error;
      _errorMessage = "회원가입을 실패했습니다.";
      _localStatus = LocalStatus.loading;
      notifyListeners();
    }
  }
}
