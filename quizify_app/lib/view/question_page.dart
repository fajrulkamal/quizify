import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizify_app/model/quiz_model.dart';
import 'package:quizify_app/viewmodel/quiz_view_model.dart'; 
import 'package:shared_preferences/shared_preferences.dart';
import 'result_page.dart'; 

class QuestionPage extends StatefulWidget {
  final int questionIndex;

  QuestionPage({Key? key, required this.questionIndex}) : super(key: key);

  @override
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  int _selectedChoiceIndex = -1;
  bool _submitted = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<QuizViewModel>(
      builder: (context, viewModel, child) {
        QuizQuestion question = viewModel.questions[widget.questionIndex];

        return Scaffold(
          appBar: AppBar(
            title: Text('Question ${widget.questionIndex + 1}'),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  question.query,
                  style: TextStyle(fontSize: 18),
                ),
              ),
              ...question.choices.asMap().entries.map((entry) {
                int idx = entry.key;
                String choice = entry.value;
                return ChoiceButton(
                  choice: choice,
                  isSelected: _selectedChoiceIndex == idx,
                  onPressed: _submitted
                      ? null
                      : () {
                          setState(() {
                            _selectedChoiceIndex = idx;
                          });
                        },
                );
              }).toList(),
              ElevatedButton(
                child: Text('Submit'),
                onPressed: _submitted
                    ? null
                    : () {
                        setState(() {
                          _submitted = true;
                          _checkAnswer(viewModel);
                        });
                      },
              ),
              if (_submitted) ...[
                Text(
                  'Correct Answer: ${question.choices[question.answer]}',
                  style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  'Explanation: ${question.explanation}',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  child: viewModel.hasMoreQuestions(widget.questionIndex) ? Text('Next Question') : Text('View Results'),
                  onPressed: () {
                    if (viewModel.hasMoreQuestions(widget.questionIndex)) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => QuestionPage(questionIndex: widget.questionIndex + 1),
                        ),
                      );
                    } else {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => ResultPage()),
                      );
                    }
                  },
                ),
              ]
            ],
          ),
        );
      },
    );
  }

  void _checkAnswer(QuizViewModel viewModel) async {
    QuizQuestion currentQuestion = viewModel.questions[widget.questionIndex];

    if (_selectedChoiceIndex == currentQuestion.answer) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int correctAnswers = prefs.getInt('correctAnswers') ?? 0;
      await prefs.setInt('correctAnswers', correctAnswers + 1);
    }
  }
}

class ChoiceButton extends StatelessWidget {
  final String choice;
  final bool isSelected;
  final VoidCallback? onPressed;

  const ChoiceButton({
    Key? key,
    required this.choice,
    required this.isSelected,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: isSelected ? Colors.blue : Colors.white,
        onPrimary: isSelected ? Colors.white : Colors.blue,
        side: BorderSide(color: Colors.blue, width: 2),
      ),
      onPressed: onPressed,
      child: Text(choice),
    );
  }
}

