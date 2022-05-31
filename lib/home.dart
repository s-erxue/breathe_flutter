import 'package:breathe_flutter/sessions.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Breathe'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
            icon: Semantics(
              label: 'Settings',
              child: const Icon(Icons.settings),
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/help');
            },
            icon: Semantics(
              label: 'Help',
              child: const Icon(Icons.help),
            ),
          )
        ],
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Sessions(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/begin');
        },
        child: const Icon(Icons.self_improvement),
      ),
    );
  }
}
