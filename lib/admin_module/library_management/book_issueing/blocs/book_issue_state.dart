class BookIssueState {
  final String category;
  final String libraryId;
  final String name;
  final String issuedDate;
  final String returnDate;
  final String copies;
  final String bookSearch;
  final List<String> selectedBooks;
  final bool showOverlay;

  BookIssueState({
    this.category = '',
    this.libraryId = '',
    this.name = '',
    this.issuedDate = '',
    this.returnDate = '',
    this.copies = '',
    this.bookSearch = '',
    this.selectedBooks = const [],
    this.showOverlay = false,
  });

  BookIssueState copyWith({
    String? category,
    String? libraryId,
    String? name,
    String? issuedDate,
    String? returnDate,
    String? copies,
    String? bookSearch,
    List<String>? selectedBooks,
    bool? showOverlay,
  }) {
    return BookIssueState(
      category: category ?? this.category,
      libraryId: libraryId ?? this.libraryId,
      name: name ?? this.name,
      issuedDate: issuedDate ?? this.issuedDate,
      returnDate: returnDate ?? this.returnDate,
      copies: copies ?? this.copies,
      bookSearch: bookSearch ?? this.bookSearch,
      selectedBooks: selectedBooks ?? this.selectedBooks,
      showOverlay: showOverlay ?? this.showOverlay,
    );
  }
}
