import 'package:gemini_talks/features/landing/model/chat_item_model.dart';

class ChatRequestModel {
  final String userUid;
  final List<ChatItemModel> history;

  ChatRequestModel(this.userUid, this.history);

  ChatRequestModel.fromJson(Map<String, dynamic> json)
      : userUid = json['userUid'],
        history = (json['history'] as List<dynamic>)
            .map((e) => ChatItemModel.fromJson(e))
            .toList();

  Map<String, dynamic> toJson() => {
        'userUid': userUid,
        'history': history.map((e) => e.toJson()).toList(),
      };

  ChatRequestModel copyWith({
    String? userUid,
    List<ChatItemModel>? history,
  }) {
    return ChatRequestModel(
      userUid ?? this.userUid,
      history ?? this.history,
    );
  }

  @override
  String toString() {
    return 'ChatRequestModel{userUid: $userUid, history: $history}';
  }
}
