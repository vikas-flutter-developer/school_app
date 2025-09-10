// Define states like Initial, Submitting, Success, Failure
// Can also hold form field values if needed for complex validation
import 'package:equatable/equatable.dart';

enum FormStatus { initial, submitting, success, failure }

class NewServiceFormState extends Equatable {
  final FormStatus status;
  final String? errorMessage;

  const NewServiceFormState({
    this.status = FormStatus.initial,
    this.errorMessage,
  });

  NewServiceFormState copyWith({FormStatus? status, String? errorMessage}) {
    return NewServiceFormState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage];
}
