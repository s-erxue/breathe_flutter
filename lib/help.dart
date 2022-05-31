import 'package:flutter/material.dart';

class Help extends StatefulWidget {
  const Help({Key? key}) : super(key: key);

  @override
  State<Help> createState() => _HelpState();
}

class _HelpState extends State<Help> {
  static const help = [
    HelpItem(
      'images/help-1.webp',
      'Click the button to start a session',
    ),
    HelpItem(
      'images/help-2.webp',
      "Answer about how you feel. Answer honestly, we won't see this.",
    ),
    HelpItem(
      'images/help-3.webp',
      'As the blue circle gets bigger, inhale. When it gets smaller, exhale.',
    ),
    HelpItem(
      'images/help-4.webp',
      'Your session will be rated depending on how you feel before and after. '
          "If you don't feel comfortable seeing your results, you can delete "
          'them.',
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Breathe'),
      ),
      body: ListView.separated(
        itemCount: help.length,
        itemBuilder: (_, i) {
          final item = help[i];
          return HelpItemView(
              provider: AssetImage(item.image), message: item.message);
        },
        separatorBuilder: (_, __) => const Divider(),
      ),
    );
  }
}

class HelpItem {
  final String image;
  final String message;

  const HelpItem(this.image, this.message);
}

class HelpItemView extends StatelessWidget {
  final ImageProvider provider;
  final String message;

  const HelpItemView({Key? key, required this.provider, required this.message})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image(image: provider),
        Text(
          message,
          style: const TextStyle(fontSize: 36),
        ),
      ],
    );
  }
}
