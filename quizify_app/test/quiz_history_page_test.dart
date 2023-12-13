import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:quizify/viewmodel/quiz_view_model.dart';
import 'package:quizify/view/quiz_history_page.dart';
import 'package:mockito/mockito.dart';

class MockQuizViewModel extends Mock implements QuizViewModel {}

void main() {
  group('QuizHistoryPage Tests', () {
    testWidgets('displays history list when available', (WidgetTester tester) async {
      final viewModel = MockQuizViewModel();
      // Mock necessary data in viewModel

      await tester.pumpWidget(
        Provider<QuizViewModel>(
          create: (_) => viewModel,
          child: MaterialApp(home: QuizHistoryPage()),
        ),
      );

      // Add assertions for list items
    });

    // Add more tests for different states
  });
}
