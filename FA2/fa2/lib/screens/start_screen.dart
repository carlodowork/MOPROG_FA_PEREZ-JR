import 'package:flutter/material.dart';
import '../constants.dart';
import '../widgets/answer_button.dart';

class StartScreen extends StatelessWidget {
  final VoidCallback onStart;

  const StartScreen({super.key, required this.onStart});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(kScreenPadding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              kWelcomeMessage,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: kTextColor,
                fontSize: kTitleFontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: kLargeGap),
            AnswerButton(text: kStartButtonText, onTap: onStart),
          ],
        ),
      ),
    );
  }
}