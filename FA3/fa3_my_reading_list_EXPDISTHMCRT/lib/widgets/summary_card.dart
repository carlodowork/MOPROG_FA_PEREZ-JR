import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import '../models/book.dart';

class SummaryCard extends StatelessWidget {
  final List<Book> books;

  const SummaryCard({super.key, required this.books});

  @override
  Widget build(BuildContext context) {
    final total = books.length;
    final finished =
        books.where((b) => b.status == ReadingStatus.finished).toList();
    final reading =
        books.where((b) => b.status == ReadingStatus.reading).length;
    final toRead =
        books.where((b) => b.status == ReadingStatus.wantToRead).length;

    final avgRating = finished.isEmpty
        ? 0.0
        : finished.map((b) => b.rating).reduce((a, b) => a + b) /
            finished.length;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Reading Summary',
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: AppSizes.smallPadding),
            Text('Total books: $total'),
            Text('Finished: ${finished.length}'),
            Text('Currently reading: $reading'),
            Text('Want to read: $toRead'),
            Text(
              finished.isEmpty
                  ? 'Average rating (finished): —'
                  : 'Average rating (finished): ${avgRating.toStringAsFixed(1)} / ${BookRules.maxRating}',
            ),
          ],
        ),
      ),
    );
  }
}