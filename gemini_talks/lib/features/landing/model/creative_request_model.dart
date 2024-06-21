class CreativeRequestModel {
  final String prompt;

  CreativeRequestModel(this.prompt);

  CreativeRequestModel.fromJson(Map<String, dynamic> json)
      : prompt = json['prompt'];

  Map<String, dynamic> toJson() => {
        'prompt': prompt,
      };

  CreativeRequestModel copyWith({
    String? prompt,
  }) {
    return CreativeRequestModel(
      prompt ?? this.prompt,
    );
  }

  @override
  String toString() {
    return 'CreativeRequestModel{prompt: $prompt}';
  }
}
