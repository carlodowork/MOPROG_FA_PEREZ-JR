import 'package:flutter/material.dart';
import '../constants.dart';
import '../models/question.dart';
import '../widgets/answer_button.dart';

class QuestionScreen extends StatelessWidget {
  final Question question;
  final int questionNumber; // 1-based
  final int totalQuestions;
  final void Function(bool isCorrect) onAnswer;

  const QuestionScreen({
    super.key,
    required this.question,
    required this.questionNumber,
    required this.totalQuestions,
    required this.onAnswer,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(kScreenPadding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Question $questionNumber of $totalQuestions',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: kTextColor,
                fontSize: kButtonFontSize,
              ),
            ),
            const SizedBox(height: kSmallGap),
            Text(
              question.text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: kTextColor,
                fontSize: kQuestionFontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: kLargeGap),
            // One AnswerButton per answer choice
            ...question.answers.map(
              (answer) => Padding(
                padding: const EdgeInsets.only(bottom: kSmallGap),
                child: AnswerButton(
                  text: answer,
                  onTap: () => onAnswer(answer == question.correctAnswer),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}