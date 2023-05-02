import "dart:developer";
import "dart:io";
import "dart:convert";
import "package:http/http.dart" as http;
import "package:petmily/providers/chat_provider.dart";
import "package:petmily/utilities/constants.dart";

const String initalPromptValue = "반려동물과 관련된 질문에 한 문장으로만 짧게 답변하세요.";

class OpenaiConnector {
  String get _domain => Constants.openai;
  String get _model => Constants.model;

  ///- Env 파일을 구성하고 민감한 값을 가리고 사용할 수 있게끔 작업해야함.
  ///String get _token => Env.get("OPENAI_SECRET_KEY")!;
  String get _token => "{YOUR_OPENAI_API_KEY_HERE}";

  ///- 사용자가 작성한 문자열을 OpenAI 모델에 전송하는 비동기 함수입니다.
  ///- `[String] input`: 사용자가 작성한 문자열을 전달 받는 파라미터입니다.
  ///- `[String] output`: 답변에 대한 문자열을 가지고 있는 변수입니다.
  Future<String> pushInput(String input) async {
    String emptyOutput = "";
    if (input.isNotEmpty) {
      try {
        var response = await http.post(
          Uri.parse("$_domain/chat/completions"),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $_token",
          },
          body: jsonEncode({
            "model": _model,
            "messages": [
              {"role": "system", "content": initalPromptValue},
              {"role": "user", "content": input}
            ],
            "temperature": 0.5,
            "max_tokens": 100,
            "top_p": 1,
            "frequency_penalty": 0,
            "presence_penalty": 0,
          }),
        );
        if (response.statusCode == 200) {
          Map<String, dynamic> responseData =
              jsonDecode(utf8.decode(response.bodyBytes));
          if (responseData["error"] != null) {
            throw HttpException(responseData["error"]["message"]);
          }
          String output = responseData['choices'][0]['message']['content']
              .toString()
              .trim();
          log(output);
          return output;
        } else {
          Map<String, dynamic> responseData =
              jsonDecode(utf8.decode(response.bodyBytes));
          log("$responseData");
          String errorMessage = "오류가 발생했습니다. 다시 시도해주세요.";
          return errorMessage;
        }
      } on SocketException {
        String errorMessage = "네트워크가 원활하지 않습니다. 다시 시도해주세요.";
        return errorMessage;
      }
    } else {
      return emptyOutput;
    }
  }
}
