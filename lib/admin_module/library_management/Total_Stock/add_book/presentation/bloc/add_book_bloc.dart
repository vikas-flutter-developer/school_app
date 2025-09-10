import 'package:flutter_bloc/flutter_bloc.dart';

part 'add_book_event.dart';
part 'add_book_state.dart';

class BookEntity {
  final String bookName;
  final String author;
  final String? subTitle;
  final String? categoryId;
  final String? accessionNo;
  final int? noOfCopies;
  final bool? issueable;

  BookEntity({
    required this.bookName,
    required this.author,
    this.subTitle,
    this.categoryId,
    this.accessionNo,
    this.noOfCopies,
    this.issueable,
  });

  BookEntity copyWith({
    String? bookName,
    String? author,
    String? subTitle,
    String? categoryId,
    String? accessionNo,
    int? noOfCopies,
    bool? issueable,
  }) {
    return BookEntity(
      bookName: bookName ?? this.bookName,
      author: author ?? this.author,
      subTitle: subTitle ?? this.subTitle,
      categoryId: categoryId ?? this.categoryId,
      accessionNo: accessionNo ?? this.accessionNo,
      noOfCopies: noOfCopies ?? this.noOfCopies,
      issueable: issueable ?? this.issueable,
    );
  }
}

class AddBookBloc extends Bloc<AddBookEvent, AddBookState> {
  BookEntity _book = BookEntity(bookName: '', author: '');

  AddBookBloc() : super(AddBookStep1()) {
    on<AddStep1Submitted>((event, emit) {
      _book = _book.copyWith(
        bookName: event.bookName,
        author: event.author,
        subTitle: event.subTitle,
      );
      emit(AddBookStep2());
    });

    on<AddStep2Submitted>((event, emit) {
      _book = _book.copyWith(
        noOfCopies: event.noOfCopies,
        issueable: event.issueable,
      );
      emit(AddBookStep3());
    });

    on<AddStep3Submitted>((event, emit) {
      _book = _book.copyWith(
        accessionNo: event.accessionNo,
        categoryId: event.categoryId,
      );
      emit(AddBookCompleted(book: _book));
    });
  }
}
