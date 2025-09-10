part of 'add_book_bloc.dart';

abstract class AddBookEvent {}

class AddStep1Submitted extends AddBookEvent {
  final String bookName;
  final String author;
  final String? subTitle;

  AddStep1Submitted({required this.bookName, required this.author, this.subTitle});
}

class AddStep2Submitted extends AddBookEvent {
  final int noOfCopies;
  final bool issueable;

  AddStep2Submitted({required this.noOfCopies, required this.issueable});
}

class AddStep3Submitted extends AddBookEvent {
  final String accessionNo;
  final String categoryId;

  AddStep3Submitted({required this.accessionNo, required this.categoryId});
}
