// confirmation_state.dart
part of 'confirmation_bloc.dart';

enum ConfirmationStatus { initial, shown }

class ConfirmationState extends Equatable {
  final ConfirmationStatus status;
  const ConfirmationState({this.status = ConfirmationStatus.initial});
  @override
  List<Object> get props => [status];
}
