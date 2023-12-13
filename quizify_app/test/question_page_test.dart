import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:quizify/viewmodel/quiz_view_model.dart';
import 'package:quizify/view/question_page.dart';
import 'package:mockito/mockito.dart';

class MockQuizViewModel extends Mock implements QuizViewModel {}

void main() {
  group('QuestionPage Tests', () {
    testWidgets('displays question and choices', (WidgetTester tester) async {
      final viewModel = MockQuizViewModel();
      // Mock necessary data and methods in viewModel

      await tester.pumpWidget(
        Provider<QuizViewModel>(
          create: (_) => viewModel,
          child: MaterialApp(home: QuestionPage(questionIndex: 0)),
        ),
      );

      // Add assertions and interactions
    });

    // Add more tests for different states and interactions
  });
}
