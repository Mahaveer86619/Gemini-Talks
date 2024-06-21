class SaveCreativeHistoryModel {
  final String prompt;
  final String response;
  final String timeStamp;
  final String userUid;

  SaveCreativeHistoryModel(
    this.prompt,
    this.response,
    this.timeStamp,
    this.userUid,
  );

  SaveCreativeHistoryModel.fromJson(Map<String, dynamic> json)
      : prompt = json['prompt'],
        response = json['response'],
        timeStamp = json['timeStamp'],
        userUid = json['userUid'];

  Map<String, dynamic> toJson() {
    return {
      'prompt': prompt,
      'response': response,
      'timeStamp': timeStamp,
      'userUid': userUid,
    };
  }

  SaveCreativeHistoryModel copyWith({
    String? prompt,
    String? response,
    String? timeStamp,
    String? userUid,
  }) {
    return SaveCreativeHistoryModel(
      prompt ?? this.prompt,
      response ?? this.response,
      timeStamp ?? this.timeStamp,
      userUid ?? this.userUid,
    );
  }

  @override
  String toString() {
    return 'SaveCreativeHistoryModel(prompt: $prompt, response: $response, timeStamp: $timeStamp, userUid: $userUid)';
  }

}
