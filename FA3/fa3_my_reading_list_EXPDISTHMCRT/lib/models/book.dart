enum ReadingStatus { wantToRead, reading, finished }

extension ReadingStatusLabel on ReadingStatus {
  String get label {
    switch (this) {
      case ReadingStatus.wantToRead:
        return 'Want to read';
      case ReadingStatus.reading:
        return 'Reading';
      case ReadingStatus.finished:
        return 'Finished';
    }
  }
}

class Book {
  final String id;
  final String title;
  final String author;
  final int pages;
  final int rating;
  final String genre;
  final ReadingStatus status;

  const Book({
    required this.id,
    required this.title,
    required this.author,
    required this.pages,
    required this.rating,
    required this.genre,
    required this.status,
  });

  Book copyWith({ReadingStatus? status}) {
    return Book(
      id: id,
      title: title,
      author: author,
      pages: pages,
      rating: rating,
      genre: genre,
      status: status ?? this.status,
    );
  }
}