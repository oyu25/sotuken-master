class Quiz {
  final String question;
  final bool answer;
  final String explanation;

  Quiz({required this.question, required this.answer, required this.explanation});

  factory Quiz.fromJson(Map<String, dynamic> json) {
    return Quiz(
      question: json['question'] ?? '',
      answer: json['answer'] ?? false ,
      explanation: json['explanation'] ?? '',
    );
  }
}
