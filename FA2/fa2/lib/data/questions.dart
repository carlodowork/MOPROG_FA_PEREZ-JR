import '../models/question.dart';

const List<Question> questions = [
  Question(
    text: 'What programming language does Flutter use?',
    answers: ['Java', 'Dart', 'Kotlin', 'Swift'],
    correctAnswer: 'Dart',
  ),
  Question(
    text: 'In Flutter, everything on the screen is a...?',
    answers: ['Widget', 'Activity', 'Fragment', 'Component'],
    correctAnswer: 'Widget',
  ),
  Question(
    text: 'Which widget is used for a widget that can change its state?',
    answers: [
      'StatelessWidget',
      'StatefulWidget',
      'InheritedWidget',
      'Container',
    ],
    correctAnswer: 'StatefulWidget',
  ),
  Question(
    text: 'Which method do you call to update the UI after changing state?',
    answers: ['refresh()', 'update()', 'setState()', 'rebuild()'],
    correctAnswer: 'setState()',
  ),
  Question(
    text: 'Which company created Flutter?',
    answers: ['Apple', 'Microsoft', 'Meta', 'Google'],
    correctAnswer: 'Google',
  ),
];