import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizify_app/model/quiz_model.dart';
import 'package:quizify_app/viewmodel/quiz_view_model.dart';
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
            backgroundColor: Color(0xFF06528A), // AppBar color
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Card(
                  elevation: 4.0,
                  margin: EdgeInsets.all(16.0),
                  color: Colors.white, // Card background color
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          question.query,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            height: 1.43,
                            letterSpacing: -0.5,
                            color: Colors.black, // Font color for the question
                          ),
                        ),
                        SizedBox(height: 24),
                        Wrap(
                          spacing: 8.0,
                          runSpacing: 8.0,
                          alignment: WrapAlignment.spaceEvenly,
                          children: question.choices.asMap().entries.map((entry) {
                            int idx = entry.key;
                            String choice = entry.value;
                            return FractionallySizedBox(
                              widthFactor: 0.45,
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
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xFF06528A), // Button background color
                            onPrimary: Colors.white, // Button text color
                          ),
                          child: Text('Submit'),
                          onPressed: _submitted
                              ? null
                              : () {
                                  setState(() {
                                    _submitted = true;
                                    viewModel.checkAnswer(widget.questionIndex, _selectedChoiceIndex);
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
                        ],
                      ],
                    ),
                  ),
                ),
                if (_submitted) ...[
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF06528A), // Button background color
                      onPrimary: Colors.white, // Button text color
                    ),
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
        primary: isSelected ? Color(0xFF06528A) : Color(0xFFC2F0EF), // Button fill color
        onPrimary: Colors.white, // Button text color for selected state
        elevation: isSelected ? 2 : 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        side: BorderSide(color: Color(0xFF2D6E96), width: 2), // Choice's outline
        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
      ),
      onPressed: onPressed,
      child: Text(choice,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black, // Text color changes based on selection
          fontFamily: 'Inter',
          ),
      )
    );
  }
}
