import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:quizify/viewmodel/quiz_view_model.dart';
import 'package:quizify/view/quiz_page.dart';
import 'package:mockito/mockito.dart';

class MockQuizViewModel extends Mock implements QuizViewModel {}

void main() {
  group('QuizPage Tests', () {
    testWidgets('displays loading indicator when data is loading', (WidgetTester tester) async {
      final viewModel = MockQuizViewModel();
      when(viewModel.isLoading).thenReturn(true);

      await tester.pumpWidget(
        Provider<QuizViewModel>(
          create: (_) => viewModel,
          child: MaterialApp(home: QuizPage()),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    // Add more tests for different states and interactions
  });
}
