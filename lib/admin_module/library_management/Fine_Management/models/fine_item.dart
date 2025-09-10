// models/fine_item.dart
class FineItem {
  final String bookTitle;
  final String? subTitle; // Optional
  final String authorsName;
  final String publisherName;
  final String issuedTo;
  final String libraryId;
  final String issuedDate;
  final String returnDate;
  final String delayFine;
  final String damageFine;
  final String imageUrl; // Path to the book cover image asset

  FineItem({
    required this.bookTitle,
    this.subTitle,
    required this.authorsName,
    required this.publisherName,
    required this.issuedTo,
    required this.libraryId,
    required this.issuedDate,
    required this.returnDate,
    required this.delayFine,
    required this.damageFine,
    required this.imageUrl,
  });
}

// Mock Data - In a real app, this would come from an API/database
final List<FineItem> mockFineItems = List.generate(
  3, // Generate 3 identical items as shown in the image
      (index) => FineItem(
    bookTitle: "Book Title",
    subTitle: "Sub Title of the book :", // Note: Label included here for simplicity
    authorsName: "Name",
    publisherName: "Name",
    issuedTo: "XYZ (Class - X)",
    libraryId: "########",
    issuedDate: "00/00/00",
    returnDate: "00/00/00",
    delayFine: "100",
    damageFine: "NA",
    imageUrl: "assets/images/physics_book.png", // Use your placeholder image path
  ),
);