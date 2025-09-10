import 'package:equatable/equatable.dart';
import '../model/employee_entity.dart';

abstract class EmployeeState extends Equatable {
  @override
  List<Object?> get props => [];
}

class EmployeeInitial extends EmployeeState {}

class EmployeeLoading extends EmployeeState {}

class EmployeeLoaded extends EmployeeState {
  final EmployeeEntity employee;

  EmployeeLoaded(this.employee);

  @override
  List<Object?> get props => [employee];
}
