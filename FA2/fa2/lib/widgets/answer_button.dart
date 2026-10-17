import 'package:flutter/material.dart';
import '../constants.dart';

/// Reusable button. Shows any [text] and calls [onTap] when pressed.
class AnswerButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const AnswerButton({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: kPrimaryColor,
        foregroundColor: kButtonTextColor,
        padding: const EdgeInsets.symmetric(
          vertical: kButtonVerticalPadding,
          horizontal: kButtonHorizontalPadding,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kButtonRadius),
        ),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: kButtonFontSize),
      ),
    );
  }
}