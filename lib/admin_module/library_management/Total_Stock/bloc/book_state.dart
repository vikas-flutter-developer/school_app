// bloc/book_state.dart
part of 'book_bloc.dart';

abstract class BookState extends Equatable {
  const BookState();

  @override
  List<Object> get props => [];
}

class BookInitial extends BookState {}

class BookLoading extends BookState {}

class BookLoaded extends BookState {
  final List<BookItem> books;

  const BookLoaded(this.books);

  @override
  List<Object> get props => [books];
}

class BookError extends BookState {
  final String message;

  const BookError(this.message);

  @override
  List<Object> get props => [message];
}