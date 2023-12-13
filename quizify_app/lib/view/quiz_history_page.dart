import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizify/viewmodel/quiz_view_model.dart';
import 'widgets/bottom_navigation_bar.dart';
import 'widgets/background.dart';

class QuizHistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<QuizViewModel>(
      builder: (context, viewModel, child) {
        if (viewModel.quizHistory.isEmpty) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Quiz History'),
              backgroundColor: Color(0xFF06528A),
            ),
            body: Center(
              child: Text('No history available.'),
            ),
            bottomNavigationBar: CustomBottomNavigationBar(currentIndex: 1),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: Text('Quiz History'),
          ),
          body: Background(child: ListView.builder(
            itemCount: viewModel.quizHistory.length,
            itemBuilder: (context, index) {
              var history = viewModel.quizHistory[index];
              int totalQuestions = history.config.numberOfQuestions;
              int correctAnswers = history.correctAnswers;
              return Card(
                child: ListTile(
                  title: Text('Topic: ${history.config.topic}'),
                  subtitle: Text('Correct Answers: $correctAnswers/$totalQuestions'),
                  trailing: Text('Difficulty: ${history.config.difficulty}'),
                ),
              );
            },
          ),
          ),
          bottomNavigationBar: CustomBottomNavigationBar(currentIndex: 1),
        );
      },
    );
  }
}
