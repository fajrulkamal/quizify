import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizify_app/viewmodel/quiz_view_model.dart';
import 'quiz_config_form.dart';
import 'question_page.dart';
import 'bottom_navigation_bar.dart';

class QuizPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<QuizViewModel>(
      builder: (context, viewModel, child) {
        if (viewModel.isLoading) {
          return Center(child: CircularProgressIndicator());
        }

        return Scaffold(
          appBar: AppBar(title: Text('Quizify App')),
          body: Padding(
            padding: EdgeInsets.all(16.0),
            child: QuizConfigForm(
              onGenerateQuiz: (numQuestions, topic, language, difficulty) {
                viewModel.generateQuiz(
                  numQuestions: int.parse(numQuestions),
                  topic: topic,
                  language: language,
                  difficulty: difficulty,
                ).then((_) {
                  if (viewModel.questions.isNotEmpty) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => QuestionPage(questionIndex: 0),
                      ),
                    );
                  }
                });
              },
            ),
          ),
          bottomNavigationBar: CustomBottomNavigationBar(currentIndex: 0),
        );
      },
    );
  }
}
