// confirmation_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'confirmation_event.dart';
part 'confirmation_state.dart';

class ConfirmationBloc extends Bloc<ConfirmationEvent, ConfirmationState> {
  ConfirmationBloc() : super(const ConfirmationState()) {
    on<ShowConfirmation>(
      (event, emit) =>
          emit(const ConfirmationState(status: ConfirmationStatus.shown)),
    );
    on<DismissConfirmation>((event, emit) {
      // Logic to handle dismissal if needed, e.g., analytics
      // State might reset or stay 'shown' depending on desired behavior
    });
  }
}
