class Question {
  String text;
  bool answer;
  String explanation;

  Question({required this.text, required this.answer, required this.explanation});

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      text: json['text'] ?? '',
      answer: json['answer'] ?? false,
      explanation: json['explanation'] ?? '',
    );
  }
}
