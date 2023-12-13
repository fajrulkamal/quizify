import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quizify/view/quiz_config_form.dart';

void main() {
  group('QuizConfigForm Tests', () {
    testWidgets('renders form fields correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(home: QuizConfigForm(onGenerateQuiz: (_, __, ___, ____) {})),
      );

      expect(find.byType(TextField), findsOneWidget);
      expect(find.byType(DropdownButtonFormField), findsNWidgets(3));
      // Add more assertions
    });

    // Add more tests for form submission and validation
  });
}
