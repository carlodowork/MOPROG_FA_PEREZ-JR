import 'package:flutter/material.dart';
import 'constants.dart';
import 'data/questions.dart';
import 'screens/question_screen.dart';
import 'screens/result_screen.dart';
import 'screens/start_screen.dart';

void main() => runApp(const QuizApp());

class QuizApp extends StatelessWidget {
  const QuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: kAppTitle,
      debugShowCheckedModeBanner: false,
      home: const Quiz(),
    );
  }
}

enum ActiveScreen { start, question, result }

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  ActiveScreen _activeScreen = ActiveScreen.start;
  int _currentIndex = 0;
  int _score = 0;

  void _startQuiz() {
    setState(() {
      _currentIndex = 0;
      _score = 0;
      _activeScreen = ActiveScreen.question;
    });
  }

  void _answerQuestion(bool isCorrect) {
    setState(() {
      if (isCorrect) _score++;
      if (_currentIndex < questions.length - 1) {
        _currentIndex++;
      } else {
        _activeScreen = ActiveScreen.result;
      }
    });
  }

  void _restartQuiz() {
    setState(() {
      _currentIndex = 0;
      _score = 0;
      _activeScreen = ActiveScreen.start;
    });
  }

  Widget _buildScreen() {
    switch (_activeScreen) {
      case ActiveScreen.start:
        return StartScreen(onStart: _startQuiz);
      case ActiveScreen.question:
        return QuestionScreen(
          key: ValueKey(_currentIndex),
          question: questions[_currentIndex],
          questionNumber: _currentIndex + 1,
          totalQuestions: questions.length,
          onAnswer: _answerQuestion,
        );
      case ActiveScreen.result:
        return ResultScreen(
          score: _score,
          total: questions.length,
          onRestart: _restartQuiz,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(child: _buildScreen()),
    );
  }
}