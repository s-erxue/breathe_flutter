import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'feeling.dart';

class FeelingScreen extends StatefulWidget {
  final bool isEnd;

  const FeelingScreen({Key? key, this.isEnd = false}) : super(key: key);

  @override
  State<FeelingScreen> createState() => _FeelingScreenState();
}

class _FeelingScreenState extends State<FeelingScreen> {
  Feeling feeling = Feeling.ok;

  Future<void> setData(String key, Feeling value) async {
    (await SharedPreferences.getInstance()).setInt(key, value.index);
  }

  Future<void> addCurrentSession() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('record') != false) {
      final begin = prefs.getInt('begin')!;
      final end = prefs.getInt('end')!;
      int effectiveness;
      switch (end - begin) {
        case 4:
        case 3:
          effectiveness = 5;
          break;
        case 2:
          effectiveness = 4;
          break;
        case 1:
          effectiveness = 3;
          break;
        case 0:
          effectiveness = 2;
          break;
        default:
          effectiveness = 1;
          break;
      }
      addSession(effectiveness);
    }
  }

  Future<void> addSession(int effectiveness) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('sessions',
        effectiveness.toString() + (prefs.getString('sessions') ?? ''));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Breathe'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('How do you feel?'),
            DropdownButton<Feeling>(
              value: feeling,
              onChanged: (f) => setState(() => feeling = f!),
              items: [
                DropdownMenuItem(
                  value: Feeling.angry,
                  child: Semantics(
                    label: 'Angry',
                    child: const Icon(Icons.sentiment_very_dissatisfied),
                  ),
                ),
                DropdownMenuItem(
                  value: Feeling.frustrated,
                  child: Semantics(
                    label: 'Frustrated',
                    child: const Icon(Icons.sentiment_dissatisfied),
                  ),
                ),
                DropdownMenuItem(
                  value: Feeling.ok,
                  child: Semantics(
                    label: 'OK',
                    child: const Icon(Icons.sentiment_neutral),
                  ),
                ),
                DropdownMenuItem(
                  value: Feeling.good,
                  child: Semantics(
                    label: 'Good',
                    child: const Icon(Icons.sentiment_satisfied),
                  ),
                ),
                DropdownMenuItem(
                  value: Feeling.great,
                  child: Semantics(
                    label: 'Great',
                    child: const Icon(Icons.sentiment_very_satisfied),
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                setData(widget.isEnd ? 'end' : 'begin', feeling);
                if (widget.isEnd) {
                  addCurrentSession();
                  Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
                } else {
                  Navigator.pushNamed(context, '/breathe');
                }
              },
              child: const Text('Next'),
            )
          ],
        ),
      ),
    );
  }
}
