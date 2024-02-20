import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing/main.dart';
import 'package:flutter_testing/screens/counter_screen.dart';
import 'package:flutter_testing/screens/user_screen.dart';

void main() {
  late Widget myApp;

  setUp(() {
    myApp = const MyApp();
  });

  group(
    'My App - ',
    () {
      testWidgets(
        'given main screen, when it is rendered, then there should be exactly two inkwell widgets, one saying "Counter" and one saying "Users"',
        (tester) async {
          await tester.pumpWidget(myApp);

          expect(find.byType(InkWell), findsExactly(2));

          expect(find.text('Counter'), findsOneWidget);
          expect(find.text('Users'), findsOneWidget);
        },
      );
      testWidgets(
          'given counter button, when it is tappped, then counter page should open',
          (WidgetTester tester) async {
        await tester.pumpWidget(myApp);

        await tester.tap(find.text('Counter'));
        await tester.pumpAndSettle();

        expect(find.byType(CounterPage), findsOneWidget);
      });

      testWidgets(
        'given user button, when it is tappped, then user page should open',
        (WidgetTester tester) async {
          await tester.pumpWidget(myApp);

          await tester.tap(find.text('Users'));
          await tester.pumpAndSettle();

          expect(find.byType(UserPage), findsOneWidget);
        },
      );
    },
  );
}
