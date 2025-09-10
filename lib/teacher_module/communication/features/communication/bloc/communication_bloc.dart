// communication_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
// Import Repositories if needed

part 'communication_event.dart';
part 'communication_state.dart';

class CommunicationBloc extends Bloc<CommunicationEvent, CommunicationState> {
  CommunicationBloc() : super(CommunicationInitial()) {
    on<LoadCommunicationOptions>(_onLoadOptions);
  }

  void _onLoadOptions(
    LoadCommunicationOptions event,
    Emitter<CommunicationState> emit,
  ) {
    // Add logic here if options or data need loading
    emit(const CommunicationLoadSuccess());
  }
}
