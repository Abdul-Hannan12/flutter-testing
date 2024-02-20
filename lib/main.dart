import 'package:flutter/material.dart';
import 'package:flutter_testing/repositories/user_repository.dart';
import 'package:flutter_testing/screens/counter_screen.dart';
import 'package:flutter_testing/screens/user_screen.dart';
import 'package:http/http.dart' show Client;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Testing Practice',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return const CounterPage();
                  },
                ),
              );
            },
            child: Container(
              height: 120,
              width: double.maxFinite,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(),
              ),
              child: const Center(
                child: Text("Counter"),
              ),
            ),
          ),
          const SizedBox(height: 50),
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return UserPage(
                      futureUsers: UserRepository(Client()).fetchUsers(),
                    );
                  },
                ),
              );
            },
            child: Container(
              height: 120,
              width: double.maxFinite,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(),
              ),
              child: const Center(
                child: Text("Users"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
