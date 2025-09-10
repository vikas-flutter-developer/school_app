part of 'add_book_bloc.dart';

abstract class AddBookState {}

class AddBookStep1 extends AddBookState {}

class AddBookStep2 extends AddBookState {}

class AddBookStep3 extends AddBookState {}

class AddBookCompleted extends AddBookState {
  final BookEntity book;

  AddBookCompleted({required this.book});
}
