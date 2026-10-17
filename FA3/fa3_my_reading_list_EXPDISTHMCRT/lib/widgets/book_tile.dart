import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import '../models/book.dart';

class BookTile extends StatelessWidget {
  final Book book;
  final ValueChanged<ReadingStatus> onStatusChanged;
  final VoidCallback onDelete;

  const BookTile({
    super.key,
    required this.book,
    required this.onStatusChanged,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.padding),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(book.title, style: textTheme.titleMedium),
                  Text('by ${book.author}', style: textTheme.bodyMedium),
                  const SizedBox(height: 4),
                  Text('${book.genre} • ${book.pages} pages',
                      style: textTheme.bodySmall),
                  const SizedBox(height: 4),
                  Row(
                    children: List.generate(
                      BookRules.maxRating,
                      (i) => Icon(
                        i < book.rating ? Icons.star : Icons.star_border,
                        color: AppColors.star,
                        size: AppSizes.starSize,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSizes.smallPadding),
                  DropdownButton<ReadingStatus>(
                    value: book.status,
                    isDense: true,
                    underline: const SizedBox(),
                    items: ReadingStatus.values
                        .map((s) => DropdownMenuItem(
                              value: s,
                              child: Text(s.label),
                            ))
                        .toList(),
                    onChanged: (value) {
                      if (value != null) onStatusChanged(value);
                    },
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.delete_outline, color: AppColors.error),
              onPressed: onDelete,
              tooltip: 'Remove book',
            ),
          ],
        ),
      ),
    );
  }
}