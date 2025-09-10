import 'package:equatable/equatable.dart';

import '../model/staff_form_model.dart';

abstract class StaffFormState extends Equatable {
  const StaffFormState();

  @override
  List<Object?> get props => [];
}

class StaffFormInitial extends StaffFormState {
  final StaffFormModel? form;

  StaffFormInitial({this.form});

  @override
  List<Object?> get props => [form];
}

class StaffFormLoading extends StaffFormState {}

class StaffFormLoaded extends StaffFormState {
  final StaffFormModel form;

  const StaffFormLoaded(this.form);

  @override
  List<Object?> get props => [form];
}

class StaffFormSubmitting extends StaffFormState {}

class StaffFormSubmitSuccess extends StaffFormState {}

class StaffFormSubmitFailure extends StaffFormState {
  final String message;

  const StaffFormSubmitFailure(this.message);

  @override
  List<Object?> get props => [message];
}
