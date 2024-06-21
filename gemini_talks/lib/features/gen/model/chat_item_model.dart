class ChatItemModel {
  final bool isUser;
  final String message;
  final String timeStamp;

  ChatItemModel(
    this.isUser,
    this.message,
    this.timeStamp,
  );

  ChatItemModel.fromJson(Map<String, dynamic> json)
      : isUser = json['isUser'],
        message = json['message'],
        timeStamp = json['timeStamp'];

  Map<String, dynamic> toJson() => {
        'isUser': isUser,
        'message': message,
        'timeStamp': timeStamp,
      };

  ChatItemModel copyWith({
    bool? isUser,
    String? message,
    String? timeStamp,
  }) {
    return ChatItemModel(
      isUser ?? this.isUser,
      message ?? this.message,
      timeStamp ?? this.timeStamp,
    );
  }

  @override
  String toString() {
    return 'ChatItemModel{isUser: $isUser, message: $message, timeStamp: $timeStamp}';
  }
}
