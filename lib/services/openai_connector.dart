import "dart:io";
import "dart:convert";
import "package:flutter/foundation.dart";
import "package:http/http.dart" as http;
import "package:petmily/utilities/constants.dart";

class OpenaiConnector {
  @protected
  String url = Constants.openai;
  @protected
  String model = Constants.model;
  //TODO: env 파일을 구성해서 예민한 값을 저장하고 사용할 수 있도록 할 예정입니다.
  @protected
  String token = "{MY_OPEN_API_KEY}";

  String get _url => url;
  String get _model => model;
  String get _token => token;

  ///- 사용자가 작성한 문자열을 OpenAI 모델에 전송하는 비동기 함수입니다.
  ///- `[String] input`: 사용자가 작성한 문자열을 전달 받는 파라미터입니다.
  ///- `[String] output`: 답변에 대한 문자열을 가지고 있는 변수입니다.
  Future<String> pushInput(String input) async {
    String emptyOutput = "";
    if (input.isNotEmpty) {
      try {
        var response = await http.post(
          Uri.parse(_url + _model),
          headers: {
            "Content-Type": "application/json",
            "Authorization": _token,
          },
          body: jsonEncode({
            "prompt": input,
            "temperature": 0.5,
            "max_tokens": 120,
            "top_p": 1,
            "frequency_penalty": 0,
            "presence_penalty": 0,
          }),
        );
        if (response.statusCode == 200) {
          Map<String, dynamic> responsedData =
              jsonDecode(utf8.decode(response.bodyBytes));
          String output = responsedData["choies"][0]["text"].toString().trim();
          return output;
        } else if (response.statusCode == 401) {
          String errorMessage = "Invalid a token";
          return errorMessage;
        } else if (response.statusCode == 402) {
          String errorMessage = "Invalid a token";
          return errorMessage;
        } else {}
      } on SocketException {
        String errorMessage = "네트워크가 원활하지 않습니다. 다시 시도해주세요.";
        return errorMessage;
      }
    } else {
      return emptyOutput;
    }
    return emptyOutput;
  }
}
