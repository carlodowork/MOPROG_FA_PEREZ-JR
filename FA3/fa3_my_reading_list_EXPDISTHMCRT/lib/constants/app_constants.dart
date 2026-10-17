import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF5B4B8A);
  static const Color secondary = Color(0xFFE8A33D);
  static const Color background = Color(0xFFF6F3FA);
  static const Color card = Colors.white;
  static const Color textDark = Color(0xFF2B2438);
  static const Color star = Color(0xFFF5B301);
  static const Color error = Color(0xFFC62828);
}

class AppSizes {
  static const double padding = 16.0;
  static const double smallPadding = 8.0;
  static const double radius = 14.0;
  static const double chartHeight = 120.0;
  static const double barWidth = 28.0;
  static const double starSize = 18.0;
}

class AppStrings {
  static const String appTitle = 'My Reading List';
  static const String emptyMessage =
      'No books yet!\nTap the + button to add your first book.';
  static const String addBook = 'Add Book';
}

class BookRules {
  static const int minRating = 1;
  static const int maxRating = 5;
  static const int minPages = 1;
  static const int maxPages = 10000;
}

const List<String> kGenres = [
  'Fiction',
  'Non-fiction',
  'Fantasy',
  'Biography',
  'Mystery',
  'Sci-Fi',
  'Other',
];