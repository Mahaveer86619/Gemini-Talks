class CreativeHistRespModel {
  final String id;
  final String prompt;
  final String response;
  final String timeStamp;
  final String userUid;

  CreativeHistRespModel({
    required this.id,
    required this.prompt,
    required this.response,
    required this.timeStamp,
    required this.userUid,
  });

  CreativeHistRespModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        prompt = json['prompt'],
        response = json['response'],
        timeStamp = json['timeStamp'],
        userUid = json['userUid'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'prompt': prompt,
        'response': response,
        'timeStamp': timeStamp,
        'userUid': userUid,
      };
  
  CreativeHistRespModel copyWith({
    String? id,
    String? prompt,
    String? response,
    String? timeStamp,
    String? userUid,
  }) {
    return CreativeHistRespModel(
      id: id ?? this.id,
      prompt: prompt ?? this.prompt,
      response: response ?? this.response,
      timeStamp: timeStamp ?? this.timeStamp,
      userUid: userUid ?? this.userUid,
    );
  }

  @override
  String toString() {
    return 'CreativeHistRespModel(id: $id, prompt: $prompt, response: $response, timeStamp: $timeStamp, userUid: $userUid)';
  }
}
