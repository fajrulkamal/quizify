import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:quizify/viewmodel/quiz_view_model.dart';
import 'package:quizify/view/result_page.dart';
import 'package:mockito/mockito.dart';

class MockQuizViewModel extends Mock implements QuizViewModel {}

void main() {
  group('ResultPage Tests', () {
    testWidgets('displays quiz results correctly', (WidgetTester tester) async {
      final viewModel = MockQuizViewModel();
      when(viewModel.correctAnswers).thenReturn(5);

      await tester.pumpWidget(
        Provider<QuizViewModel>(
          create: (_) => viewModel,
          child: MaterialApp(home: ResultPage()),
        ),
      );

      expect(find.text('You answered 5 questions correctly!'), findsOneWidget);
    });

    // Add more tests for different states and interactions
  });
}
