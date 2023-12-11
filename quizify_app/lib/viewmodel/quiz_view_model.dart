import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:quizify_app/model/quiz_model.dart';
import 'config.dart';
import 'package:quizify_app/model/quiz_configuration.dart';
import 'package:quizify_app/model/quiz_history.dart';

class QuizViewModel with ChangeNotifier {
  List<QuizQuestion> _questions = [];
  bool _isLoading = false;
  int _correctAnswers = 0;

  List<QuizQuestion> get questions => _questions;
  bool get isLoading => _isLoading;
  int get correctAnswers => _correctAnswers;

  set isLoading(value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> generateQuiz({
    required int numQuestions, 
    required String topic, 
    required String language, 
    required String difficulty
  }) async {
    isLoading = true;
    final apiKey = Config.apiKey;
    final endpoint = "https://api.openai.com/v1/chat/completions";
    final prompt = 'Give me $numQuestions multiple choice questions about $topic in the $language language. The questions should be at $difficulty level. return your answer entirely in the form of a JSON Object. The JSON Object should have a key named "questions" which is an array of the questions. each quiz question should include the choices, the answer, and a brief explanation of why the answer is correct. Do not include anything other than the JSON. The JSON properties of each question should be "query" (which is the question), "choices", "answer", and "explanation". the choices should not have any ordinal value like A, B, C, D or a number like 1, 2, 3, 4. The answer should be the 0-indexed number of the correct choice.';
    const model = "gpt-3.5-turbo";

    final response = await http.post(
      Uri.parse(endpoint),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $apiKey",
      },
      body: jsonEncode({
        "messages": [{"role": 'user', "content": prompt}],
        "model": model,
        "max_tokens": 2048,
        "temperature": 0.6,
        "top_p": 1,
        "frequency_penalty": 0,
        "presence_penalty": 0,
        "stream": false,
        "n": 1
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final questionsJson = jsonDecode(data['choices'][0]['message']['content'])['questions'] as List;
      _questions = questionsJson.map((qJson) => QuizQuestion.fromJson(qJson)).toList();
    } else {
      print("Error: ${response.statusCode}");
      print("Error Message: ${response.body}");
    }
    isLoading = false;
  }

  bool hasMoreQuestions(int questionIndex) {
    return questionIndex < _questions.length - 1;
  }

  void checkAnswer(int questionIndex, int selectedChoiceIndex) {
    if (selectedChoiceIndex == _questions[questionIndex].answer) {
      _correctAnswers++;
    }
  }

  List<QuizHistory> _quizHistory = [];

  List<QuizHistory> get quizHistory => _quizHistory;

  void saveQuizResult(QuizConfiguration config, int correctAnswers) {
    _quizHistory.add(QuizHistory(config, correctAnswers));
    notifyListeners();
  }

  void resetQuiz() {
    _questions.clear();
    _correctAnswers = 0;
    notifyListeners();
  }
}
