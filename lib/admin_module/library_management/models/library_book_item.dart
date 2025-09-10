// models/library_book_item.dart (Create this file)
import 'package:equatable/equatable.dart';

class LibraryBookItem extends Equatable {
  final String id; // Unique ID for the book item/loan
  final String title;
  final String subtitle;
  final String author;
  final String issuedTo; // e.g., "XYZ (class-X)"
  final String libraryId; // Placeholder text from UI
  final String issuedDate; // Placeholder text from UI
  final String returnDate; // Placeholder text from UI
  final String imageUrl; // Path or URL to the book cover

  const LibraryBookItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.author,
    required this.issuedTo,
    required this.libraryId,
    required this.issuedDate,
    required this.returnDate,
    required this.imageUrl,
  });

  @override
  List<Object?> get props => [
    id, title, subtitle, author, issuedTo, libraryId, issuedDate, returnDate, imageUrl
  ];
}

// Dummy Data - Create separate lists for each tab's potential data
const String _dummyImageUrl = 'assets/images/book.jpg'; // Use your actual path or a placeholder

final List<LibraryBookItem> dummyIssuedBooks = List.generate(
  15, // Example: generate 15 items
      (index) => LibraryBookItem(
    id: 'issued_${index + 1}',
    title: 'Book Title ${index + 1}',
    subtitle: 'Sub Title of the book',
    author: 'Authors Name: Name',
    issuedTo: 'Issued to- XYZ (class-X)',
    libraryId: 'Library ID-',
    issuedDate: 'Issued date-',
    returnDate: 'Return date-',
    imageUrl: _dummyImageUrl,
  ),
);

final List<LibraryBookItem> dummyReceivedBooks = List.generate(
  8, // Example: different count
      (index) => LibraryBookItem(
    id: 'received_${index + 1}',
    title: 'Received Book ${index + 1}',
    subtitle: 'Another Sub Title',
    author: 'Author: Another Name',
    issuedTo: 'Received from- ABC (class-IX)', // Different text
    libraryId: 'Lib ID-',
    issuedDate: 'Received date-', // Different text
    returnDate: 'Returned on-', // Different text
    imageUrl: _dummyImageUrl, // Use different image maybe
  ),
);

final List<LibraryBookItem> dummyDueBooks = List.generate(
  5, // Example: different count
      (index) => LibraryBookItem(
    id: 'due_${index + 1}',
    title: 'Due Book ${index + 1}',
    subtitle: 'A Third Sub Title',
    author: 'Author: Yet Another',
    issuedTo: 'Issued to- PQR (class-XI)', // Different text
    libraryId: 'Library ID-',
    issuedDate: 'Issued date-',
    returnDate: 'Due date-', // Different text
    imageUrl: _dummyImageUrl,
  ),
);