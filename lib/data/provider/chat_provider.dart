import 'package:flutter/material.dart';
import '../../domain/entities/chat_message.dart';

class ChatProvider extends ChangeNotifier {
  final List<ChatMessage> _messages = [];

  List<ChatMessage> get messages => _messages;

  void updateMessage(ChatMessage message) {
    ChatMessage updatedMessage = message.copyWith();
    notifyListeners();
  }

}
