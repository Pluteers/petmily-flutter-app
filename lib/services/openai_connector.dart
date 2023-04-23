import "dart:developer";
import "package:flutter/foundation.dart";
import "package:http/http.dart" as http;
import "package:petmily/utilities/constants.dart";

class OpenaiConnector {
  @protected
  var url = Constants.openai;
  @protected
  var model = Constants.model;

  ///예시
  void pushInput() async {
    var response = await http.post(Uri.parse(url + model));
    if (response.statusCode == 200) {
      var responsedData = response.body;
      log(responsedData);
    } else {
      log("Connection Failed.");
    }
  }

  ///예시
  void takeOutput() async {
    var response = await http.get(Uri.parse(url + model));
    if (response.statusCode == 200) {
      var responsedData = response.body;
      log(responsedData);
    } else {
      log("Connection Failed.");
    }
  }
}
