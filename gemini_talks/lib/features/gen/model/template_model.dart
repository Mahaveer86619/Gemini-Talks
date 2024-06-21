class TemplateModel {
  final String title;
  final String prompt;

  TemplateModel({
    required this.title,
    required this.prompt,
  });

  TemplateModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        prompt = json['prompt'];

  Map<String, dynamic> toJson() => {
        'title': title,
        'prompt': prompt,
      };
  
  TemplateModel copyWith({
    String? title,
    String? prompt,
  }) {
    return TemplateModel(
      title: title ?? this.title,
      prompt: prompt ?? this.prompt,
    );
  }

  @override
  String toString() {
    return 'TemplateModel(title: $title, prompt: $prompt)';
  }
}
