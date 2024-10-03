import 'package:flutter/material.dart';
import 'package:tech_test/profile/profile.dart';
import 'package:tech_test/splash_screen.dart';

import 'agenda/add_agenda.dart';
import 'agenda/agenda.dart';
import 'login/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Deptech Test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/login': (context) => const LoginPage(),
        '/profile': (context) => const ProfilePage(),
        '/agenda': (context) => const AgendaPage(),
        '/addAgenda': (context) => const AddAgendaPage(),
      },
    );
  }
}