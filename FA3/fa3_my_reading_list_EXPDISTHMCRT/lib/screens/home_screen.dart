import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import '../models/book.dart';
import '../widgets/bar_chart.dart';
import '../widgets/book_form.dart';
import '../widgets/book_tile.dart';
import '../widgets/summary_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Book> _books = [];

  void _addBook(Book book) {
    setState(() => _books.add(book));
    Navigator.pop(context); // close the form
  }

  void _updateStatus(Book book, ReadingStatus newStatus) {
    setState(() {
      final index = _books.indexWhere((b) => b.id == book.id);
      if (index != -1) {
        _books[index] = book.copyWith(status: newStatus);
      }
    });
  }

  void _removeBook(Book book) {
    setState(() => _books.removeWhere((b) => b.id == book.id));
  }

  void _openForm() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => BookForm(onSubmit: _addBook),
    );
  }

  Map<String, int> get _genreCounts {
    final counts = <String, int>{};
    for (final book in _books) {
      counts[book.genre] = (counts[book.genre] ?? 0) + 1;
    }
    return counts;
  }

  Map<String, int> get _statusCounts {
    return {
      for (final s in ReadingStatus.values)
        s.label: _books.where((b) => b.status == s).length,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.appTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _openForm,
            tooltip: AppStrings.addBook,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openForm,
        child: const Icon(Icons.add),
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 90),
        children: [
          SummaryCard(books: _books),
          SimpleBarChart(
            title: 'Books by Status',
            data: _statusCounts,
            barColor: AppColors.primary,
          ),
          SimpleBarChart(
            title: 'Books by Genre',
            data: _genreCounts,
            barColor: AppColors.secondary,
          ),
          if (_books.isEmpty)
            const Padding(
              padding: EdgeInsets.all(AppSizes.padding * 2),
              child: Center(
                child: Text(
                  AppStrings.emptyMessage,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
              ),
            )
          else
            ..._books.map(
              (book) => BookTile(
                key: ValueKey(book.id),
                book: book,
                onStatusChanged: (s) => _updateStatus(book, s),
                onDelete: () => _removeBook(book),
              ),
            ),
        ],
      ),
    );
  }
}