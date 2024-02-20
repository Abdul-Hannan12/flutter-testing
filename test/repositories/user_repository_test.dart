import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing/models/user.dart';
import 'package:flutter_testing/repositories/user_repository.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';

class MockHttpClient extends Mock implements Client {}

void main() {
  late UserRepository userRepository;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    userRepository = UserRepository(mockHttpClient);
  });
  group(
    'UserRepository - ',
    () {
      group(
        'getUser function - ',
        () {
          test(
            'given UserRepository class when getUser function is called and status code is 200, then a User should be returned',
            () async {
              //arranges
              when(
                () => mockHttpClient.get(
                  Uri.parse('https://jsonplaceholder.typicode.com/users/1'),
                ),
              ).thenAnswer(
                (invocation) async {
                  return Response('''
                    {
                      "id": 1,
                      "name": "Leanne Graham",
                      "username": "Bret",
                      "email": "Sincere@april.biz",
                      "website": "hildegard.org"
                    }
                    ''', 200);
                },
              );
              final user = await userRepository.getUser();
              expect(user, isA<User>());
            },
          );

          test(
            'given UserRepository class when getUser function is called and status code is not 200, then an exception should be thrown',
            () async {
              when(
                () {
                  return mockHttpClient.get(
                    Uri.parse('https://jsonplaceholder.typicode.com/users/1'),
                  );
                },
              ).thenAnswer(
                (invocation) async {
                  return Response('{}', 404);
                },
              );

              final user = userRepository.getUser();
              expect(user, throwsException);
            },
          );
        },
      );

      group(
        'fetchUsers function - ',
        () {
          test(
            'given UserRepository class when fetchUsers function is called and status code is 200, then a List of Users should be returned',
            () async {
              //arranges
              when(
                () => mockHttpClient.get(
                  Uri.parse('https://jsonplaceholder.typicode.com/users'),
                ),
              ).thenAnswer(
                (invocation) async {
                  return Response('''
                    [
                      {
                        "id": 1,
                        "name": "Leanne Graham",
                        "username": "Bret",
                        "email": "Sincere@april.biz",
                        "website": "hildegard.org"
                      },
                      {
                        "id": 2,
                        "name": "Ervin Howell",
                        "username": "Antonette",
                        "email": "Shanna@melissa.tv",
                        "website": "anastasia.net"
                      }
                    ]
                    ''', 200);
                },
              );
              final users = await userRepository.fetchUsers();
              expect(users, isA<List<User>>());
            },
          );

          test(
            'given UserRepository class when fetchUsers function is called and status code is not 200, then an exception should be thrown',
            () async {
              when(
                () {
                  return mockHttpClient.get(
                    Uri.parse('https://jsonplaceholder.typicode.com/users'),
                  );
                },
              ).thenAnswer(
                (invocation) async {
                  return Response('[]', 500);
                },
              );

              final users = userRepository.fetchUsers();
              expect(users, throwsException);
            },
          );
        },
      );
    },
  );
}
