import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizify_app/viewmodel/quiz_view_model.dart';

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final _viewModel = QuizViewModel();
  final _topicController = TextEditingController();
  String _selectedNumQuestions = '5';
  String _selectedLanguage = 'English';
  String _selectedDifficulty = 'Easy';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<QuizViewModel>(
      create: (context) => _viewModel,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Quizify App'),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
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
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (_topicController.text.isNotEmpty) {
              Provider.of<QuizViewModel>(context, listen: false).generateStory(
                numQuestions: int.parse(_selectedNumQuestions),
                topic: _topicController.text,
                language: _selectedLanguage,
                difficulty: _selectedDifficulty,
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Please enter a topic'),
                ),
              );
            }
          },
          tooltip: 'Generate Quiz',
          child: Icon(Icons.play_arrow),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _topicController.dispose();
    super.dispose();
  }
}