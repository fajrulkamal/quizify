import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizify_app/viewmodel/quiz_view_model.dart';
import 'bottom_navigation_bar.dart';

class QuizHistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<QuizViewModel>(
      builder: (context, viewModel, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Quiz History'),
          ),
          body: ListView.builder(
            itemCount: viewModel.quizHistory.length,
            itemBuilder: (context, index) {
              var history = viewModel.quizHistory[index];
              return Card(
                child: ListTile(
                  title: Text('Topic: ${history.config.topic}'),
                  subtitle: Text('Correct Answers: ${history.correctAnswers}'),
                  trailing: Text('Difficulty: ${history.config.difficulty}'),
                  // Add more details as needed
                ),
              );
            },
          ),
          bottomNavigationBar: CustomBottomNavigationBar(currentIndex: 1),
        );
      },
    );
  }
}
