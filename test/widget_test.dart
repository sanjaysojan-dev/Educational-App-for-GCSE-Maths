// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:educational_app_for_maths/widgets/ExplanationCard.dart';
import 'package:educational_app_for_maths/widgets/OptionsCard.dart';
import 'package:educational_app_for_maths/widgets/QuestionCard.dart';
import 'package:educational_app_for_maths/widgets/QuestionImageCard.dart';
import 'package:educational_app_for_maths/widgets/StepTitleCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

//import 'package:image_test_utils/image_test_utils.dart';
import 'package:network_image_mock/network_image_mock.dart';

void main() {
  ///Test function to test whether ExplanationCard loads accordingly
  testWidgets('ExplanationCard Test', (WidgetTester tester) async {
    // Builds widget
    await tester.pumpWidget(
        ExplanationCard(step: "Explanation", color: Colors.white30));

    final titleFinder = find.text("Explanation");
    expect(titleFinder, findsOneWidget);
  });

  ///Test function to test whether OptionsCard loads accordingly
  testWidgets('OptionsCard Test', (WidgetTester tester) async {
    // Builds widget
    await tester
        .pumpWidget(OptionsCard(option: "Option", color: Colors.white30));

    final titleFinder = find.text("Option");
    expect(titleFinder, findsOneWidget);
  });

  ///Test function to test whether QuestionCard loads accordingly
  testWidgets('QuestionsCard Test', (WidgetTester tester) async {
    // Builds widget
    await tester.pumpWidget(QuestionCard(question: "Question"));

    final titleFinder = find.text("Question");
    expect(titleFinder, findsOneWidget);
  });

  ///Test function to test whether StepTitleCard loads accordingly
  testWidgets('StepTitleCard Test', (WidgetTester tester) async {
    // Builds widget
    await tester.pumpWidget(StepTitleCard(title: "Title"));

    final titleFinder = find.text("Title");
    expect(titleFinder, findsOneWidget);
  });

  ///Test function to test whether QuestionImageCard loads accordingly
  testWidgets(
    'should properly mock Image.network and not crash',
    (WidgetTester tester) async {
      await mockNetworkImagesFor(() => tester.pumpWidget(MaterialApp(
          home: QuestionImageCard(
              image:
                  'https://images.pexels.com/photos/13064584/pexels-photo-13064584.jpeg?auto=compress&cs='
                  'tinysrgb&w=1260&h=750&dpr=1'))));
      expect(find.byType(Image), findsOneWidget);
    },
  );
}
