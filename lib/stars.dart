import 'package:flutter/material.dart';

class Stars extends StatelessWidget {
  final int stars;

  const Stars(this.stars, {Key? key}) : super(key: key);

  static const star = Icon(Icons.star);
  static const emptyStar = Icon(Icons.star_border);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (var i = 0; i < stars; i++) star,
        for (var i = 0; i < (5 - stars); i++) emptyStar,
      ],
    );
  }
}
