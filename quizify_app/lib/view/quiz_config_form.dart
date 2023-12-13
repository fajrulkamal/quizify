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

  TextStyle get _textStyle => TextStyle(
    fontFamily: 'Inter',
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: -0.5,
    color: Colors.black,
  );

  OutlineInputBorder _outlineInputBorder() {
    return OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFF06528A)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          TextField(
            controller: _topicController,
            decoration: InputDecoration(
              labelText: 'Topic',
              labelStyle: _textStyle,
              border: _outlineInputBorder(),
              enabledBorder: _outlineInputBorder(),
              focusedBorder: _outlineInputBorder(),
            ),
          ),
          SizedBox(height: 20),
          DropdownButtonFormField<String>(
            value: _selectedNumQuestions,
            decoration: InputDecoration(
              labelText: 'Number of Questions',
              labelStyle: _textStyle,
              border: _outlineInputBorder(),
              enabledBorder: _outlineInputBorder(),
              focusedBorder: _outlineInputBorder(),
            ),
            items: ['5', '10', '15', '20']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value, style: _textStyle),
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
              labelStyle: _textStyle,
              border: _outlineInputBorder(),
              enabledBorder: _outlineInputBorder(),
              focusedBorder: _outlineInputBorder(),
            ),
            items: ['English', 'Spanish', 'French', 'German']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value, style: _textStyle),
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
              labelStyle: _textStyle,
              border: _outlineInputBorder(),
              enabledBorder: _outlineInputBorder(),
              focusedBorder: _outlineInputBorder(),
            ),
            items: ['Easy', 'Medium', 'Hard']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value, style: _textStyle),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _selectedDifficulty = newValue!;
              });
            },
          ),
          SizedBox(height: 20),
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
            backgroundColor: Color(0xFF06528A),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _topicController.dispose();
    super.dispose();
  }
}
