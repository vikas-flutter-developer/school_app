import 'package:flutter_bloc/flutter_bloc.dart';
import 'book_issue_event.dart';
import 'book_issue_state.dart';

class BookIssueBloc extends Bloc<BookIssueEvent, BookIssueState> {
  BookIssueBloc() : super(BookIssueState()) {
    on<UpdateCategory>((event, emit) {
      emit(state.copyWith(category: event.category));
    });

    on<UpdateField>((event, emit) {
      switch (event.field) {
        case 'libraryId':
          emit(state.copyWith(libraryId: event.value));
          break;
        case 'name':
          emit(state.copyWith(name: event.value));
          break;
        case 'issuedDate':
          emit(state.copyWith(issuedDate: event.value));
          break;
        case 'returnDate':
          emit(state.copyWith(returnDate: event.value));
          break;
        case 'copies':
          emit(state.copyWith(copies: event.value));
          break;
        case 'bookSearch':
          emit(state.copyWith(bookSearch: event.value));
          break;
      }
    });

    on<ToggleBookSelection>((event, emit) {
      final updatedList = List<String>.from(state.selectedBooks);
      if (updatedList.contains(event.bookName)) {
        updatedList.remove(event.bookName);
      } else {
        updatedList.add(event.bookName);
      }
      emit(state.copyWith(selectedBooks: updatedList));
    });

    on<SubmitIssue>((event, emit) {
      // No backend logic yet; just log state
      print("Issued books: ${state.selectedBooks}");
    });
  }
}
