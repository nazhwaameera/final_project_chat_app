class ChatMessage {
  bool isFirstInSequence;
  String userImage;
  String username;
  String message;
  String imageMessage;
  bool isMe;

  ChatMessage({
    required this.isFirstInSequence,
    required this.userImage,
    required this.username,
    required this.message,
    required this.imageMessage,
    required this.isMe,
  });
}