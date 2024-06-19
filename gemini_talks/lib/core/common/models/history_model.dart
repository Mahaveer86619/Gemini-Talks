class HistoryModel {
  final String id;
  final String title;
  final bool isChat;

  HistoryModel({required this.id, required this.title, required this.isChat});

  HistoryModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        isChat = json['isChat'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'isChat': isChat,
    };
  }

  @override
  String toString() {
    return 'HistoryModel(id: $id, title: $title, isChat: $isChat)';
  }
}
