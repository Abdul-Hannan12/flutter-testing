import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing/models/user.dart';
import 'package:flutter_testing/screens/user_screen.dart';

void main() {
  group(
    'Users Page - ',
    () {
      testWidgets(
        'Displays List of users with name as title and email as subtitle',
        (tester) async {
          final users = [
            User(email: 'email', name: 'name', id: 1, website: 'website'),
            User(email: 'email', name: 'name', id: 2, website: 'website'),
          ];
          Future<List<User>> getMockUsers() async {
            return Future.delayed(const Duration(seconds: 1), () => users);
          }

          await tester.pumpWidget(
            MaterialApp(
              home: UserPage(
                futureUsers: getMockUsers(),
              ),
            ),
          );

          expect(find.byType(CircularProgressIndicator), findsOne);

          await tester.pumpAndSettle();

          expect(find.byType(ListView), findsOne);
          expect(find.byType(ListTile), findsNWidgets(users.length));

          for (final user in users) {
            expect(find.text(user.name), findsOne);
            expect(find.text(user.email), findsOne);
          }
        },
      );
    },
  );
}
