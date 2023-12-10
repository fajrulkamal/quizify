class QuizQuestion {
  String query;
  List<String> choices;
  int answer;
  String explanation;

  QuizQuestion({
    required this.query,
    required this.choices,
    required this.answer,
    required this.explanation,
  });

  factory QuizQuestion.fromJson(Map<String, dynamic> json) {
    return QuizQuestion(
      query: json['query'],
      choices: List<String>.from(json['choices']),
      answer: json['answer'],
      explanation: json['explanation'],
    );
  }
}
