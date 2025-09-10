// bloc/fine_state.dart
part of 'fine_bloc.dart'; // Link to the Bloc file

abstract class FineState extends Equatable {
  const FineState();

  @override
  List<Object> get props => [];
}

// Initial state
class FineInitial extends FineState {}

// State while data is loading
class FineLoading extends FineState {}

// State when data is successfully loaded
class FineLoaded extends FineState {
  final List<FineItem> fineItems;

  const FineLoaded(this.fineItems);

  @override
  List<Object> get props => [fineItems];
}

// State when an error occurs
class FineError extends FineState {
  final String message;

  const FineError(this.message);

  @override
  List<Object> get props => [message];
}