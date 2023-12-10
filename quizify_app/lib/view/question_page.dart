import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizify_app/model/quiz_model.dart';
import 'package:quizify_app/viewmodel/quiz_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'result_page.dart';

class QuestionPage extends StatelessWidget {
  final int questionIndex;

  QuestionPage({Key? key, required this.questionIndex}) : super(key: key);

  void _handleAnswer(BuildContext context, QuizViewModel viewModel, String selectedChoice) async {
    // Logic to check if the answer is correct
    if (selectedChoice == viewModel.questions[questionIndex].answer) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int correctAnswers = prefs.getInt('correctAnswers') ?? 0;
      await prefs.setInt('correctAnswers', correctAnswers + 1);
    }

    if (viewModel.hasMoreQuestions(questionIndex)) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => QuestionPage(questionIndex: questionIndex + 1),
          ),
        );
      } else {
        // Navigate to the ResultPage
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ResultPage()),
        );
      }

  }

  @override
  Widget build(BuildContext context) {
    return Consumer<QuizViewModel>(
      builder: (context, viewModel, child) {
        QuizQuestion question = viewModel.questions[questionIndex];

        return Scaffold(
          appBar: AppBar(
            title: Text('Question ${questionIndex + 1}'),
          ),
          body: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  question.query,
                  style: TextStyle(fontSize: 24.0),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: question.choices.length,
                    itemBuilder: (context, index) {
                      return ElevatedButton(
                        child: Text(question.choices[index]),
                        onPressed: () => _handleAnswer(context, viewModel, question.choices[index]),
                      );
                    },
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  child: Text(viewModel.hasMoreQuestions(questionIndex) ? 'Next' : 'Submit'),
                  onPressed: () => _handleAnswer(context, viewModel, question.choices[0]), // Assuming the first choice is selected for simplicity
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
