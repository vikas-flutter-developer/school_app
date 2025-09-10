// models/book_item.dart
enum BookAvailability { available, outOfStock }

class BookItem {
  final String bookTitle;
  final String subTitle;
  final String authorsName;
  final String rackNameNo;
  final String isbn;
  final String accNo;
  final String imageUrl;
  final BookAvailability availability;

  BookItem({
    required this.bookTitle,
    required this.subTitle,
    required this.authorsName,
    required this.rackNameNo,
    required this.isbn,
    required this.accNo,
    required this.imageUrl,
    required this.availability,
  });
}

// Mock Data
final List<BookItem> mockBookItems = [
  BookItem(
    bookTitle: "Book Title",
    subTitle: "Sub Title of the book",
    authorsName: "Name",
    rackNameNo: "2",
    isbn: "1234576",
    accNo: "2",
    imageUrl: "assets/images/book_physics.png",
    availability: BookAvailability.available,
  ),
  BookItem(
    bookTitle: "Book Title",
    subTitle: "Sub Title of the book",
    authorsName: "Name",
    rackNameNo: "2",
    isbn: "1234576",
    accNo: "2",
    imageUrl: "assets/images/book_physics.png",
    availability: BookAvailability.outOfStock,
  ),
  BookItem(
    bookTitle: "Book Title",
    subTitle: "Sub Title of the book",
    authorsName: "Name",
    rackNameNo: "2",
    isbn: "1234576",
    accNo: "2",
    imageUrl: "assets/images/book_physics.png",
    availability: BookAvailability.available,
  ),
  BookItem(
    bookTitle: "Book Title",
    subTitle: "Sub Title of the book",
    authorsName: "Name",
    rackNameNo: "2",
    isbn: "1234576",
    accNo: "2",
    imageUrl: "assets/images/book_physics.png",
    availability: BookAvailability.available, // Last item also available in mock data
  ),
];