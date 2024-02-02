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

  ChatMessage copyWith({
    bool? isFirstInSequence,
    String? userImage,
    String? username,
    String? message,
    String? imageMessage,
    bool? isMe,
  }) {
    return ChatMessage(
        isFirstInSequence: isFirstInSequence ?? this.isFirstInSequence,
        userImage: userImage ?? this.userImage,
        username: username ?? this.username,
        message: message ?? this.message,
        imageMessage: imageMessage ?? this.imageMessage,
        isMe: isMe ?? this.isMe
    );
  }
}