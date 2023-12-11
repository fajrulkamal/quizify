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
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  question.query,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 24),
                // Replace this with a Wrap widget to create a 2x2 grid
                Wrap(
                  spacing: 8.0, // spacing between adjacent chips
                  runSpacing: 8.0, // spacing between lines
                  alignment: WrapAlignment.spaceEvenly,
                  children: question.choices.asMap().entries.map((entry) {
                    int idx = entry.key;
                    String choice = entry.value;
                    return FractionallySizedBox(
                      widthFactor: 0.45, // takes 45% of the container width
                      child: ChoiceButton(
                        choice: choice,
                        isSelected: _selectedChoiceIndex == idx,
                        onPressed: _submitted
                            ? null
                            : () {
                                setState(() {
                                  _selectedChoiceIndex = idx;
                                });
                              },
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: 24),
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
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Explanation: ${question.explanation}',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
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
        primary: isSelected ? Colors.blue[600] : Colors.white,
        onPrimary: Colors.black,
        elevation: isSelected ? 2 : 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        side: BorderSide(color: Colors.blue, width: 2),
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      ),
      onPressed: onPressed,
      child: Text(
        choice,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.blue,
        ),
      ),
    );
  }
}
