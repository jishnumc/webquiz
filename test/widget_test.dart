import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:webquiz/app.dart';

void main() {
  testWidgets('WebQuiz launches and renders home screen', (WidgetTester tester) async {
    // Set simulated screen size to a desktop web browser (1200x800)
    tester.view.physicalSize = const Size(1200, 800);
    tester.view.devicePixelRatio = 1.0;

    // Build our app under ProviderScope and trigger a frame.
    await tester.pumpWidget(
      const ProviderScope(
        child: App(),
      ),
    );

    // Verify that the title and question/explanation details are shown.
    expect(find.text('Quiz Application UI'), findsOneWidget);
    expect(find.textContaining('A train passes a station platform'), findsNWidgets(2));

    // Reset physical size after test
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
  });
}
