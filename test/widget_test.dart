import 'package:calculator/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Calculator performs addition correctly',
      (WidgetTester tester) async {
    //=== Build the widget
    await tester.pumpWidget(
      const MaterialApp(
        home: MyHomePage(),
      ),
    );

    //=== Verify initial state
    expect(find.text('0.00'), findsOneWidget);

    //=== Tap the button '1'
    await tester.tap(find.text('1'));
    await tester.pump();

    //=== Verify display updates to '1'
    expect(find.text('1.00'), findsOneWidget);

    //=== Tap the button '+'
    await tester.tap(find.text('+'));
    await tester.pump();

    //=== Tap the button '2'
    await tester.tap(find.text('2'));
    await tester.pump();

    //=== Verify display updates to '2'
    expect(find.text('2.00'), findsOneWidget);

    //=== Tap the '=' button
    await tester.tap(find.text('='));
    await tester.pump();

    //=== Verify the result is '3.00'
    expect(find.text('3.00'), findsOneWidget);
  });

  testWidgets('Calculator performs subtraction correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: MyHomePage(),
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

    //=== Verify the result is '2.00'
    expect(find.text('2.00'), findsOneWidget);
  });

  testWidgets('Calculator performs multiplication correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: MyHomePage(),
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

    //=== Verify the result is '12.00'
    expect(find.text('12.00'), findsOneWidget);
  });

  testWidgets('Calculator performs division correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: MyHomePage(),
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

    //=== Verify the result is '4.00'
    expect(find.text('4.00'), findsOneWidget);
  });

  testWidgets('Calculator clears input correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: MyHomePage(),
      ),
    );

    //=== Tap the button '8'
    await tester.tap(find.text('8'));
    await tester.pump();

    //=== Tap the button 'CLEAR'
    await tester.tap(find.text('CLEAR'));
    await tester.pump();

    //=== Verify the result is '0.00'
    expect(find.text('0.00'), findsOneWidget);
  });
}
