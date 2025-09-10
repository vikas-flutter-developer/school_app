// bloc/fine_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../models/fine_item.dart'; // Adjust path as needed

// Import parts
part 'fine_event.dart';
part 'fine_state.dart';

class FineBloc extends Bloc<FineEvent, FineState> {
  FineBloc() : super(FineInitial()) {
    on<LoadFineData>(_onLoadFineData);
  }

  Future<void> _onLoadFineData(
      LoadFineData event,
      Emitter<FineState> emit,
      ) async {
    emit(FineLoading());
    try {
      // Simulate network delay or database fetch
      await Future.delayed(const Duration(milliseconds: 500));

      // In a real app, fetch data from a repository/API
      // For now, use the mock data
      final items = mockFineItems;

      emit(FineLoaded(items));
    } catch (e) {
      emit(FineError("Failed to load fine data: ${e.toString()}"));
    }
  }
}