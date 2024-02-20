import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing/screens/counter_screen.dart';

void main() {
  late Widget counterPage;

  setUp(() {
    counterPage = const MaterialApp(home: CounterPage());
  });

  group(
    'Counter Page - ',
    () {
      testWidgets(
        'given counter screen, when we navigate to the screen, then there should be an appbar, text as label saying "Count: " and a text as counter with value 0 and three floating action buttons',
        (tester) async {
          await tester.pumpWidget(counterPage);

          expect(find.byType(AppBar), findsOneWidget);
          expect(
            find.byWidgetPredicate(
              (widget) => widget is Text && widget.data == "Count: ",
            ),
            findsOneWidget,
          );
          expect(
            find.byWidgetPredicate(
                (widget) => widget is Text && widget.data == '0'),
            findsOneWidget,
          );
          expect(find.byType(FloatingActionButton), findsExactly(3));
        },
      );
      testWidgets(
        'given counter is 0, when increment button is pressed, then counter should be 1',
        (tester) async {
          await tester.pumpWidget(counterPage);

          final counter = find.text('1');
          expect(counter, findsNothing);

          final counter2 = find.text('0');
          expect(counter2, findsOneWidget);

          final incrementBtn = find.byWidgetPredicate(
            (widget) =>
                widget is FloatingActionButton && widget.tooltip == 'Increment',
          );
          await tester.tap(incrementBtn);

          await tester.pumpAndSettle();

          final counter3 = find.text('1');
          expect(counter3, findsOneWidget);

          final counter4 = find.text('0');
          expect(counter4, findsNothing);
        },
      );
      testWidgets(
        'given counter is 0, when decrement button is pressed, then counter should still be 0',
        (tester) async {
          await tester.pumpWidget(counterPage);

          final counter = find.text('0');
          expect(counter, findsOneWidget);

          final decrementBtn = find.byWidgetPredicate(
            (widget) =>
                widget is FloatingActionButton && widget.tooltip == 'Decrement',
          );
          await tester.tap(decrementBtn);

          await tester.pumpAndSettle();

          final counter2 = find.text('0');
          expect(counter2, findsOneWidget);

          final counter3 = find.text('1');
          expect(counter3, findsNothing);
        },
      );
      testWidgets(
        'given counter is 1, when decrement button is pressed, then counter should be 0',
        (tester) async {
          await tester.pumpWidget(counterPage);

          final counter = find.text('0');
          expect(counter, findsOneWidget);

          final incrementBtn = find.byWidgetPredicate(
            (widget) =>
                widget is FloatingActionButton && widget.tooltip == 'Increment',
          );
          await tester.tap(incrementBtn);

          await tester.pumpAndSettle();

          final counter2 = find.text('1');
          expect(counter2, findsOneWidget);

          final counter3 = find.text('0');
          expect(counter3, findsNothing);

          final decrementBtn = find.byWidgetPredicate(
            (widget) =>
                widget is FloatingActionButton && widget.tooltip == 'Decrement',
          );
          await tester.tap(decrementBtn);

          await tester.pumpAndSettle();

          final counter4 = find.text('0');
          expect(counter4, findsOne);

          final counter5 = find.text('1');
          expect(counter5, findsNothing);
        },
      );

      testWidgets(
        'given counter is 1, when reset button is pressed, then counter should be 0',
        (tester) async {
          await tester.pumpWidget(counterPage);

          final counter = find.text('0');
          expect(counter, findsOneWidget);

          final incrementBtn = find.byWidgetPredicate(
            (widget) =>
                widget is FloatingActionButton && widget.tooltip == 'Increment',
          );
          await tester.tap(incrementBtn);

          await tester.pumpAndSettle();

          final counter2 = find.text('1');
          expect(counter2, findsOneWidget);

          final counter3 = find.text('0');
          expect(counter3, findsNothing);

          final resetBtn = find.byWidgetPredicate(
            (widget) =>
                widget is FloatingActionButton && widget.tooltip == 'Reset',
          );
          await tester.tap(resetBtn);

          await tester.pumpAndSettle();

          final counter4 = find.text('0');
          expect(counter4, findsOne);

          final counter5 = find.text('1');
          expect(counter5, findsNothing);
        },
      );
    },
  );
}
