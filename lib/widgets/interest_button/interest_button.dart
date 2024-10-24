import 'package:flutter/material.dart';

class InterestTextButton extends StatelessWidget {
  final text;

  const InterestTextButton({super.key, this.text});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: text,
      ),
    );
  }
}
