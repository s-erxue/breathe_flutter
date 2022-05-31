import 'package:breathe_flutter/settings.dart';
import 'package:flutter/material.dart';

import 'breathe.dart';
import 'feeling_screen.dart';
import 'help.dart';
import 'home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Breathe',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.blue,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (_) => const Home(),
        '/settings': (_) => const Settings(),
        '/help': (_) => const Help(),
        '/begin': (_) => const FeelingScreen(),
        '/breathe': (_) => const Breathe(next: '/end'),
        '/end': (_) => const FeelingScreen(isEnd: true),
      },
    );
  }
}
