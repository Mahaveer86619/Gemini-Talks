class CreativeTemplateModel {
  final String headline;
  final String prompt;
  const CreativeTemplateModel({required this.headline, required this.prompt});

  CreativeTemplateModel.fromJson(Map<String, dynamic> json)
      : headline = json['headline'],
        prompt = json['prompt'];

  Map<String, dynamic> toJson() => {
        'headline': headline,
        'prompt': prompt,
      };

  @override
  String toString() {
    return 'CreativeTemplateModel(headline: $headline, prompt: $prompt)';
  }
}
