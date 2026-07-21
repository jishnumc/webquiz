import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webquiz/app.dart';
import 'package:webquiz/src/outer_layer/clients/storage_client.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets('WebQuiz launches, renders desktop layout, navigates and selects answers', (WidgetTester tester) async {
    // Set simulated screen size to a desktop web browser (1200x800)
    tester.view.physicalSize = const Size(1200, 800);
    tester.view.devicePixelRatio = 1.0;

    final sharedPrefs = await SharedPreferences.getInstance();

    // Build our app under ProviderScope and trigger a frame.
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(sharedPrefs),
        ],
        child: const App(),
      ),
    );

    await tester.pumpAndSettle();

    // 1. Verify that the title and first question details are shown.
    expect(find.text('Quiz Application UI'), findsOneWidget);
    expect(find.textContaining('A train passes a station platform'), findsOneWidget);

    // 2. Click option '240 m' (index 1, correct answer)
    final correctOptionFinder = find.text('240 m');
    expect(correctOptionFinder, findsOneWidget);
    await tester.tap(correctOptionFinder);
    await tester.pumpAndSettle();

    // 3. Verify that the explanation is now displayed.
    expect(find.text('Explanation'), findsOneWidget);
    expect(find.textContaining('Speed = 54 * (5/18)'), findsOneWidget);

    // 4. Test Navigation: Tap "Next"
    final nextBtnFinder = find.text('Next');
    expect(nextBtnFinder, findsOneWidget);
    await tester.tap(nextBtnFinder);
    await tester.pumpAndSettle();

    // Verify Question 2 is rendered
    expect(find.textContaining('simple interest amounts to Rs. 815'), findsOneWidget);

    // 5. Test Navigation: Tap "Prev"
    final prevBtnFinder = find.text('Prev');
    expect(prevBtnFinder, findsOneWidget);
    await tester.tap(prevBtnFinder);
    await tester.pumpAndSettle();

    // Verify back to Question 1
    expect(find.textContaining('A train passes a station platform'), findsOneWidget);

    // Reset physical size after test
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
  });

  testWidgets('WebQuiz launches and renders mobile layout', (WidgetTester tester) async {
    // Set simulated screen size to a mobile phone (500x800)
    tester.view.physicalSize = const Size(500, 800);
    tester.view.devicePixelRatio = 1.0;

    final sharedPrefs = await SharedPreferences.getInstance();

    // Build our app under ProviderScope and trigger a frame.
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(sharedPrefs),
        ],
        child: const App(),
      ),
    );

    await tester.pumpAndSettle();

    // Verify mobile header
    expect(find.text('Quiz Application UI'), findsOneWidget);
    expect(find.textContaining('A train passes a station platform'), findsOneWidget);

    // Reset physical size after test
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
  });
}
