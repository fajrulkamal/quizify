import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizify_app/viewmodel/quiz_view_model.dart';

class ResultPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<QuizViewModel>(
      builder: (context, viewModel, child) {
        return Scaffold(
          appBar: AppBar(
            title: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text('Quiz Results'),
            ),
              backgroundColor: Color(0xFF06528A),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'You answered ${viewModel.correctAnswers} questions correctly!',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    viewModel.saveQuizResult(); // Updated to call without parameters
                    viewModel.resetQuiz();
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                  child: Text('Back to Home'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
