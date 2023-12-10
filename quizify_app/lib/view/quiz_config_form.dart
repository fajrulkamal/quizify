import 'package:flutter/material.dart';

class QuizConfigForm extends StatefulWidget {
  final Function(String, String, String, String) onGenerateQuiz;

  QuizConfigForm({Key? key, required this.onGenerateQuiz}) : super(key: key);

  @override
  _QuizConfigFormState createState() => _QuizConfigFormState();
}

class _QuizConfigFormState extends State<QuizConfigForm> {
  final _topicController = TextEditingController();
  String _selectedNumQuestions = '5';
  String _selectedLanguage = 'English';
  String _selectedDifficulty = 'Easy';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextField(
          controller: _topicController,
          decoration: InputDecoration(
            labelText: 'Topic',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: _selectedNumQuestions,
                decoration: InputDecoration(
                  labelText: 'Number of Questions',
                  border: OutlineInputBorder(),
                ),
                items: ['5', '10', '15', '20']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedNumQuestions = newValue!;
                  });
                },
              ),
              SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: _selectedLanguage,
                decoration: InputDecoration(
                  labelText: 'Language',
                  border: OutlineInputBorder(),
                ),
                items: ['English', 'Spanish', 'French', 'German']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedLanguage = newValue!;
                  });
                },
              ),
              SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: _selectedDifficulty,
                decoration: InputDecoration(
                  labelText: 'Difficulty',
                  border: OutlineInputBorder(),
                ),
                items: ['Easy', 'Medium', 'Hard']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedDifficulty = newValue!;
                  });
                },
              ),
        FloatingActionButton(
          onPressed: () {
            if (_topicController.text.isNotEmpty) {
              widget.onGenerateQuiz(
                _selectedNumQuestions,
                _topicController.text,
                _selectedLanguage,
                _selectedDifficulty,
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Please enter a topic')),
              );
            }
          },
          tooltip: 'Generate Quiz',
          child: Icon(Icons.play_arrow),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _topicController.dispose();
    super.dispose();
  }
}
