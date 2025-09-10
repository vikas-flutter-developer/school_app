class BookEntity {
  final String bookName;
  final String author;
  final String? subTitle;
  final String? edition;
  final String? isbnNo;
  final String? publication;
  final int? noOfCopies;
  final bool? issueable;
  final String? accessionNo;
  final String? categoryId;

  BookEntity({
    required this.bookName,
    required this.author,
    this.subTitle,
    this.edition,
    this.isbnNo,
    this.publication,
    this.noOfCopies,
    this.issueable,
    this.accessionNo,
    this.categoryId,
  });

  BookEntity copyWith({
    String? bookName,
    String? author,
    String? subTitle,
    String? edition,
    String? isbnNo,
    String? publication,
    int? noOfCopies,
    bool? issueable,
    String? accessionNo,
    String? categoryId,
  }) {
    return BookEntity(
      bookName: bookName ?? this.bookName,
      author: author ?? this.author,
      subTitle: subTitle ?? this.subTitle,
      edition: edition ?? this.edition,
      isbnNo: isbnNo ?? this.isbnNo,
      publication: publication ?? this.publication,
      noOfCopies: noOfCopies ?? this.noOfCopies,
      issueable: issueable ?? this.issueable,
      accessionNo: accessionNo ?? this.accessionNo,
      categoryId: categoryId ?? this.categoryId,
    );
  }
}
