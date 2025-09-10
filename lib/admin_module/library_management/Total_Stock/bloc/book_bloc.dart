// bloc/book_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../models/book_item.dart'; // Adjust path

part 'book_event.dart';
part 'book_state.dart';

class BookBloc extends Bloc<BookEvent, BookState> {
  BookBloc() : super(BookInitial()) {
    on<LoadBookData>(_onLoadBookData);
  }

  Future<void> _onLoadBookData(
      LoadBookData event,
      Emitter<BookState> emit,
      ) async {
    emit(BookLoading());
    try {
      // Simulate API call
      await Future.delayed(const Duration(milliseconds: 500));
      // Use mock data
      emit(BookLoaded(mockBookItems));
    } catch (e) {
      emit(BookError("Failed to load books: ${e.toString()}"));
    }
  }
}