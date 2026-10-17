import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import '../models/book.dart';

class BookForm extends StatefulWidget {
  final ValueChanged<Book> onSubmit;

  const BookForm({super.key, required this.onSubmit});

  @override
  State<BookForm> createState() => _BookFormState();
}

class _BookFormState extends State<BookForm> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _authorController = TextEditingController();
  final _pagesController = TextEditingController();
  final _ratingController = TextEditingController();

  String _genre = kGenres.first;
  ReadingStatus _status = ReadingStatus.wantToRead;

  @override
  void dispose() {
    _titleController.dispose();
    _authorController.dispose();
    _pagesController.dispose();
    _ratingController.dispose();
    super.dispose();
  }

  String? _validateRequired(String? value, String field) {
    if (value == null || value.trim().isEmpty) {
      return '$field cannot be empty';
    }
    return null;
  }

  String? _validatePages(String? value) {
    final pages = int.tryParse(value?.trim() ?? '');
    if (pages == null) return 'Enter a valid whole number';
    if (pages < BookRules.minPages || pages > BookRules.maxPages) {
      return 'Pages must be between ${BookRules.minPages} and ${BookRules.maxPages}';
    }
    return null;
  }

  String? _validateRating(String? value) {
    final rating = int.tryParse(value?.trim() ?? '');
    if (rating == null) return 'Enter a valid whole number';
    if (rating < BookRules.minRating || rating > BookRules.maxRating) {
      return 'Rating must be ${BookRules.minRating} to ${BookRules.maxRating}';
    }
    return null;
  }

  void _save() {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fix the errors before saving.'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    final book = Book(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      title: _titleController.text.trim(),
      author: _authorController.text.trim(),
      pages: int.parse(_pagesController.text.trim()),
      rating: int.parse(_ratingController.text.trim()),
      genre: _genre,
      status: _status,
    );
    widget.onSubmit(book);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: AppSizes.padding,
        right: AppSizes.padding,
        top: AppSizes.padding,
        bottom: MediaQuery.of(context).viewInsets.bottom + AppSizes.padding,
      ),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(AppStrings.addBook,
                  style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: AppSizes.padding),
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (v) => _validateRequired(v, 'Title'),
              ),
              const SizedBox(height: AppSizes.smallPadding),
              TextFormField(
                controller: _authorController,
                decoration: const InputDecoration(labelText: 'Author'),
                validator: (v) => _validateRequired(v, 'Author'),
              ),
              const SizedBox(height: AppSizes.smallPadding),
              TextFormField(
                controller: _pagesController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Pages'),
                validator: _validatePages,
              ),
              const SizedBox(height: AppSizes.smallPadding),
              TextFormField(
                controller: _ratingController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText:
                      'Rating (${BookRules.minRating}-${BookRules.maxRating})',
                ),
                validator: _validateRating,
              ),
              const SizedBox(height: AppSizes.smallPadding),
              DropdownButtonFormField<String>(
                value: _genre,
                decoration: const InputDecoration(labelText: 'Genre'),
                items: kGenres
                    .map((g) => DropdownMenuItem(value: g, child: Text(g)))
                    .toList(),
                onChanged: (v) => setState(() => _genre = v!),
              ),
              const SizedBox(height: AppSizes.smallPadding),
              DropdownButtonFormField<ReadingStatus>(
                value: _status,
                decoration: const InputDecoration(labelText: 'Status'),
                items: ReadingStatus.values
                    .map((s) =>
                        DropdownMenuItem(value: s, child: Text(s.label)))
                    .toList(),
                onChanged: (v) => setState(() => _status = v!),
              ),
              const SizedBox(height: AppSizes.padding),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _save,
                  child: const Text('Save Book'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}