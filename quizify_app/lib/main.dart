
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'view/quiz_page.dart';
import 'package:quizify_app/viewmodel/quiz_view_model.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => QuizViewModel(),
      child: MaterialApp(
        title: 'Quizify App',
        home: QuizPage(),
      ),
    ),
  );
}
