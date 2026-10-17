import 'package:flutter/material.dart';
import '../constants.dart';
import '../widgets/answer_button.dart';

class ResultScreen extends StatelessWidget {
  final int score;
  final int total;
  final VoidCallback onRestart;

  const ResultScreen({
    super.key,
    required this.score,
    required this.total,
    required this.onRestart,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(kScreenPadding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'You got $score out of $total correct!',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: kTextColor,
                fontSize: kTitleFontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: kLargeGap),
            AnswerButton(text: kRestartButtonText, onTap: onRestart),
          ],
        ),
      ),
    );
  }
}