import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizify_app/viewmodel/quiz_view_model.dart';
import 'quiz_config_form.dart';
import 'question_page.dart'; // Assuming you have this file

class QuizPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<QuizViewModel>(
      builder: (context, viewModel, child) {
        if (viewModel.isLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (!viewModel.isLoading && viewModel.questions.isNotEmpty) {
          Future.microtask(() => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => QuestionPage(questionIndex: 0),
                ),
              ));
        }

        return Scaffold(
          appBar: AppBar(title: Text('Quizify App')),
          body: Padding(
            padding: EdgeInsets.all(16.0),
            child: QuizConfigForm(
              onGenerateQuiz: (numQuestions, topic, language, difficulty) {
                Provider.of<QuizViewModel>(context, listen: false)
                    .generateStory(
                  numQuestions: int.parse(numQuestions),
                  topic: topic,
                  language: language,
                  difficulty: difficulty,
                );
              },
            ),
          ),
        );
      },
    );
  }
}
