import 'package:calculator/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Calculator performs addition correctly',
      (WidgetTester tester) async {
    //=== Build the widget
    await tester.pumpWidget(
      const MaterialApp(
        home: MyHomePage(
          title: "",
        ),
      ),
    );

    //=== Verify initial state
    final displayFinder =
        find.byKey(const Key('display')); //=== Target the display widget
    expect(displayFinder, findsOneWidget); //=== Ensure the display shows exists
    expect((tester.widget(displayFinder) as Text).data,
        "0"); //=== Verify the display shows "0"

    //=== Tap the button '1'
    await tester.tap(find.text('1'));
    await tester.pump();

    expect(
        displayFinder, findsOneWidget); //=== Verify that display updates to "1"
    expect((tester.widget(displayFinder) as Text).data,
        "1"); //=== Verify the display shows "1"

    //=== Tap the button '+'
    await tester.tap(find.text('+'));
    await tester.pump();

    //=== Tap the button '2'
    await tester.tap(find.text('2'));
    await tester.pump();

    //=== Verify the result is '2'
    expect(
        displayFinder, findsOneWidget); //=== Ensure the display widget exists
    expect((tester.widget(displayFinder) as Text).data,
        "2"); //=== Verify the display shows "2"

    //=== Tap the '=' button
    await tester.tap(find.text('='));
    await tester.pump();

    //=== Verify the result is '3'
    expect(
        displayFinder, findsOneWidget); //=== Ensure the display widget exists
    expect((tester.widget(displayFinder) as Text).data, "3.0");
  }); //=== Verify the display shows "3"

  testWidgets('Calculator performs subtraction correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: MyHomePage(
          title: '',
        ),
      ),
    );

    //=== Tap the button '5'
    await tester.tap(find.text('5'));
    await tester.pump();

    //=== Tap the button '-'
    await tester.tap(find.text('-'));
    await tester.pump();

    //=== Tap the button '3'
    await tester.tap(find.text('3'));
    await tester.pump();

    //=== Tap the '=' button
    await tester.tap(find.text('='));
    await tester.pump();

    //=== Verify the result is '2'
    expect(find.byKey(const Key('display')),
        findsOneWidget); // Target the display widget
    expect(find.text('2'), findsOneWidget); // Ensure the display shows "2"
  });

  testWidgets('Calculator performs multiplication correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: MyHomePage(
          title: '',
        ),
      ),
    );

    //=== Tap the button '3'
    await tester.tap(find.text('3'));
    await tester.pump();

    //=== Tap the button 'X'
    await tester.tap(find.text('X'));
    await tester.pump();

    //=== Tap the button '4'
    await tester.tap(find.text('4'));
    await tester.pump();

    //=== Tap the '=' button
    await tester.tap(find.text('='));
    await tester.pump();

    //=== Verify the result is '12'
    final displayFinder = find.byKey(const Key('display'));
    final displayWidget = tester.widget(displayFinder) as Text;
    expect(displayFinder, findsOneWidget); // Ensure the display widget exists
    expect(displayWidget.data!.trim(),
        "12.0"); // Verify the display shows "12" (trim extra spaces)
  });

  testWidgets('Calculator performs division correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: MyHomePage(
          title: '',
        ),
      ),
    );

    //=== Tap the button '8'
    await tester.tap(find.text('8'));
    await tester.pump();

    //=== Tap the button '/'
    await tester.tap(find.text('/'));
    await tester.pump();

    //=== Tap the button '2'
    await tester.tap(find.text('2'));
    await tester.pump();

    //=== Tap the '=' button
    await tester.tap(find.text('='));
    await tester.pump();

    //=== Verify the result is '4'
    expect(find.byKey(const Key('display')),
        findsOneWidget); // Target the display widget
    expect(find.text('4'), findsOneWidget); // Ensure the display shows "4"
  });

  testWidgets('Calculator clears input correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: MyHomePage(
          title: '',
        ),
      ),
    );

    //=== Tap the button '8'
    await tester.tap(find.text('8'));
    await tester.pump();

    //=== Tap the button 'CLEAR'
    await tester.tap(find.text('CLEAR'));
    await tester.pump();

    //=== Verify the result is '0'
    final displayFinder =
        find.byKey(const Key('display')); // Target the display widget
    expect(displayFinder, findsOneWidget); // Ensure the display widget exists
    expect((tester.widget(displayFinder) as Text).data,
        "0"); // Verify the display shows "0"
  });
  testWidgets('Calculator handles square root correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: MyHomePage(
          title: '',
        ),
      ),
    );

    //=== Tap the button '9'
    await tester.tap(find.text('9'));
    await tester.pump();

    //=== Tap the button '√'
    await tester.tap(find.text('√'));
    await tester.pump();

    //=== Verify the result is '3'
    expect(find.byKey(const Key('display')),
        findsOneWidget); // Target the display widget
    expect(find.text('3'), findsOneWidget); // Ensure the display shows "3"
  });

  testWidgets('Calculator handles percentage correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: MyHomePage(
          title: '',
        ),
      ),
    );

    //=== Tap the button '5'
    await tester.tap(find.text('5'));
    await tester.pump();

    //=== Tap the button '0'
    await tester.tap(find.text('0'));
    await tester.pump();

    //=== Tap the button '%'
    await tester.tap(find.text('%'));
    await tester.pump();

    //=== Verify the result is '0.5'
    expect(find.byKey(const Key('display')),
        findsOneWidget); // Target the display widget
    expect(find.text('0.5'), findsOneWidget); // Ensure the display shows "0.5"
  });

  testWidgets('Calculator handles power correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: MyHomePage(
          title: '',
        ),
      ),
    );

    //=== Tap the button '2'
    await tester.tap(find.text('2'));
    await tester.pump();

    //=== Tap the button '^'
    await tester.tap(find.text('^'));
    await tester.pump();

    //=== Tap the button '3'
    await tester.tap(find.text('3'));
    await tester.pump();

    //=== Tap the '=' button
    await tester.tap(find.text('='));
    await tester.pump();

    //=== Verify the result is '8'
    expect(find.byKey(const Key('display')),
        findsOneWidget); // Target the display widget
    expect(find.text('8'), findsOneWidget); // Ensure the display shows "8"
  });

  testWidgets('Calculator handles negation correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: MyHomePage(
          title: '',
        ),
      ),
    );

    //=== Tap the button '5'
    await tester.tap(find.text('5'));
    await tester.pump();

    //=== Tap the button '±'
    await tester.tap(find.text('±'));
    await tester.pump();

    //=== Verify the result is '-5'
    final displayFinder = find.byKey(const Key('display'));
    final displayWidget = tester.widget(displayFinder) as Text;
    expect(
        displayFinder, findsOneWidget); //=== Ensure the display widget exists
    expect(displayWidget.data, "-5.0"); //=== Verify the display shows "-5"
  });

  testWidgets('Calculator handles division by zero correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: MyHomePage(
          title: '',
        ),
      ),
    );

    //=== Tap the button '8'
    await tester.tap(find.byKey(const Key('button_8'))); // Use unique key
    await tester.pump();

    //=== Tap the button '/'
    await tester.tap(find.byKey(const Key('button_/'))); // Use unique key
    await tester.pump();

    //=== Tap the button '0'
    await tester.tap(find.byKey(const Key('button_0'))); // Use unique key
    await tester.pump();

    //=== Tap the '=' button
    await tester.tap(find.byKey(const Key('button_='))); // Use unique key
    await tester.pump();

    //=== Verify the result is 'Error'
    expect(find.byKey(const Key('display')),
        findsOneWidget); // Target the display widget
    expect(
        find.text('Error'), findsOneWidget); // Ensure the display shows "Error"
  });
}
