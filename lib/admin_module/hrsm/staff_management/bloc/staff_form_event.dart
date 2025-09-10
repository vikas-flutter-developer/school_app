import 'package:equatable/equatable.dart';

abstract class StaffFormEvent extends Equatable {
  const StaffFormEvent();

  @override
  List<Object?> get props => [];
}

class LoadStaffFormData extends StaffFormEvent {}

class StaffFormFieldChanged extends StaffFormEvent {
  final String fieldName;
  final String value;

  const StaffFormFieldChanged(this.fieldName, this.value);

  @override
  List<Object?> get props => [fieldName, value];
}

class SubmitStaffForm extends StaffFormEvent {}
