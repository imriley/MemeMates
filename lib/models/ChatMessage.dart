class ChatMessage {
  String senderId;
  String receiverId;
  String messageType;
  String content;

  ChatMessage(
    this.senderId,
    this.receiverId,
    this.messageType,
    this.content,
  );

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'messageType': messageType,
      'content': content,
    };
  }

  factory ChatMessage.fromMap(Map<String, dynamic> map) {
    return ChatMessage(
      map['senderId'],
      map['receiverId'],
      map['messageType'],
      map['content'],
    );
  }
}
