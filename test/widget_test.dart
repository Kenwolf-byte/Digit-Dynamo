import 'package:calculator/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart'; // For mocking persistent storage

void main() {
  // Mock SharedPreferences for testing persistent storage
  SharedPreferences.setMockInitialValues({});

  testWidgets('Calculator performs addition correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: MyHomePage(
          title: '',
        ),
      ),
    );

    expect(find.text('0'), findsOneWidget);

    await tester.tap(find.text('1'));
    await tester.pump();
    expect(find.text('1'), findsOneWidget);

    await tester.tap(find.text('+'));
    await tester.pump();

    await tester.tap(find.text('2'));
    await tester.pump();
    expect(find.text('2'), findsOneWidget);

    await tester.tap(find.text('='));
    await tester.pump();
    expect(find.text('3'), findsOneWidget);
  });

  testWidgets('Calculator adds calculation to history',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: MyHomePage(
          title: '',
        ),
      ),
    );

    // Perform a calculation
    await tester.tap(find.text('5'));
    await tester.pump();
    await tester.tap(find.text('+'));
    await tester.pump();
    await tester.tap(find.text('3'));
    await tester.pump();
    await tester.tap(find.text('='));
    await tester.pump();

    // Open history dialog
    await tester.tap(find.byIcon(Icons.history));
    await tester.pumpAndSettle();

    // Verify the calculation is in the history
    expect(find.text('5.0 + 3.0 = 8'), findsOneWidget);
  });

  testWidgets('Calculator saves history to persistent storage',
      (WidgetTester tester) async {
    // Mock SharedPreferences
    SharedPreferences.setMockInitialValues({});

    await tester.pumpWidget(
      const MaterialApp(
        home: MyHomePage(
          title: '',
        ),
      ),
    );

    // Perform a calculation
    await tester.tap(find.text('7'));
    await tester.pump();
    await tester.tap(find.text('-'));
    await tester.pump();
    await tester.tap(find.text('2'));
    await tester.pump();
    await tester.tap(find.text('='));
    await tester.pump();

    // Verify history is saved
    final prefs = await SharedPreferences.getInstance();
    final history = prefs.getStringList('history');
    expect(history, isNotNull);
    expect(history!.contains('7.0 - 2.0 = 5'), isTrue);
  });

  testWidgets('Calculator loads history from persistent storage',
      (WidgetTester tester) async {
    // Mock SharedPreferences with initial history
    SharedPreferences.setMockInitialValues({
      'history': ['3.0 * 4.0 = 12'],
    });

    await tester.pumpWidget(
      const MaterialApp(
        home: MyHomePage(
          title: '',
        ),
      ),
    );

    // Open history dialog
    await tester.tap(find.byIcon(Icons.history));
    await tester.pumpAndSettle();

    // Verify the history is loaded
    expect(find.text('3.0 * 4.0 = 12'), findsOneWidget);
  });

  testWidgets('Calculator reuses history entry', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: MyHomePage(
          title: '',
        ),
      ),
    );

    // Perform a calculation
    await tester.tap(find.text('9'));
    await tester.pump();
    await tester.tap(find.text('/'));
    await tester.pump();
    await tester.tap(find.text('3'));
    await tester.pump();
    await tester.tap(find.text('='));
    await tester.pump();

    // Open history dialog
    await tester.tap(find.byIcon(Icons.history));
    await tester.pumpAndSettle();

    // Tap on the history entry to reuse it
    await tester.tap(find.text('9.0 / 3.0 = 3'));
    await tester.pump();

    // Verify the result is reused
    expect(find.text('3'), findsOneWidget);
  });

  testWidgets('Calculator clears history', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: MyHomePage(
          title: '',
        ),
      ),
    );

    // Perform a calculation
    await tester.tap(find.text('4'));
    await tester.pump();
    await tester.tap(find.text('X'));
    await tester.pump();
    await tester.tap(find.text('5'));
    await tester.pump();
    await tester.tap(find.text('='));
    await tester.pump();

    // Open history dialog
    await tester.tap(find.byIcon(Icons.history));
    await tester.pumpAndSettle();

    // Tap the "Clear History" button
    await tester.tap(find.text('Clear History'));
    await tester.pump();

    // Confirm clearing history
    await tester.tap(find.text('Clear'));
    await tester.pumpAndSettle();

    // Verify history is cleared
    expect(find.text('4.0 X 5.0 = 20'), findsNothing);
  });

  testWidgets('Calculator deletes individual history entry',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: MyHomePage(
          title: '',
        ),
      ),
    );

    // Perform a calculation
    await tester.tap(find.text('6'));
    await tester.pump();
    await tester.tap(find.text('+'));
    await tester.pump();
    await tester.tap(find.text('4'));
    await tester.pump();
    await tester.tap(find.text('='));
    await tester.pump();

    // Open history dialog
    await tester.tap(find.byIcon(Icons.history));
    await tester.pumpAndSettle();

    // Tap the delete button next to the history entry
    await tester.tap(find.byIcon(Icons.delete));
    await tester.pump();

    // Verify the history entry is deleted
    expect(find.text('6.0 + 4.0 = 10'), findsNothing);
  });
}
