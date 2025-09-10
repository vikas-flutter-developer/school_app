// bloc/fine_event.dart
part of 'fine_bloc.dart'; // Link to the Bloc file

abstract class FineEvent extends Equatable {
  const FineEvent();

  @override
  List<Object> get props => [];
}

// Event to trigger loading the data
class LoadFineData extends FineEvent {}