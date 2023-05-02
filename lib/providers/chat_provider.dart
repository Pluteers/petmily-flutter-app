import 'package:flutter/foundation.dart';
import 'package:petmily/services/openai_connector.dart';

class MessageModel {
  final String text;
  final bool isUser;

  MessageModel({
    required this.text,
    required this.isUser,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      text: json['content'],
      isUser: json['role'] == 'user',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'role': isUser ? 'user' : 'assistant',
      'content': text,
    };
  }
}

class ChatProvider extends ChangeNotifier {
  List<MessageModel> messages = [];
  OpenaiConnector get openaiConnector => OpenaiConnector();

  void setMessages(MessageModel message) {
    messages.add(message);
    notifyListeners();
  }
}
