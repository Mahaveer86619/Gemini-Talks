import 'package:gemini_talks/features/gen/model/chat_item_model.dart';

class SaveChatHistoryModel {
  final String userUid;
  final List<ChatItemModel> history;

  SaveChatHistoryModel(
    this.userUid,
    this.history,
  );

  SaveChatHistoryModel.fromJson(Map<String, dynamic> json)
      : userUid = json['userUid'],
        history = (json['history'] as List<dynamic>)
            .map((e) => ChatItemModel.fromJson(e))
            .toList();

  Map<String, dynamic> toJson() => {
        'userUid': userUid,
        'history': history.map((e) => e.toJson()).toList(),
      };

  SaveChatHistoryModel copyWith({
    String? userUid,
    List<ChatItemModel>? history,
  }) {
    return SaveChatHistoryModel(
      userUid ?? this.userUid,
      history ?? this.history,
    );
  }

  @override
  String toString() {
    return 'SaveChatHistoryModel{userUid: $userUid, history: $history}';
  }
}
