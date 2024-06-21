import 'package:gemini_talks/features/gen/model/chat_item_model.dart';

class ChatHistRespModel {
  final String id;
  final String prompt;
  final List<ChatItemModel> chatItems;
  final String userUid;

  ChatHistRespModel({
    required this.id,
    required this.prompt,
    required this.chatItems,
    required this.userUid,
  });

  ChatHistRespModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        prompt = json['prompt'],
        chatItems = List<ChatItemModel>.from(
          json['history'].map((e) => ChatItemModel.fromJson(e)),
        ),
        userUid = json['userUid'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'prompt': prompt,
        'history': List<dynamic>.from(chatItems.map((e) => e.toJson())),
        'userUid': userUid,
      };

  ChatHistRespModel copyWith({
    String? id,
    String? prompt,
    List<ChatItemModel>? chatItems,
    String? userUid,
  }) {
    return ChatHistRespModel(
      id: id ?? this.id,
      prompt: prompt ?? this.prompt,
      chatItems: chatItems ?? this.chatItems,
      userUid: userUid ?? this.userUid,
    );
  }

  @override
  String toString() {
    return 'ChatHistRespModel(id: $id, prompt: $prompt, chatItems: $chatItems, userUid: $userUid)';
  }
}
